<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useTipoDocumentos } from "@/composables/tipo_documentos/useTipoDocumentos";
import { useAxios } from "@/composables/axios/useAxios";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
import axios from "axios";
const props = defineProps({
    open_dialog: {
        type: Boolean,
        default: false,
    },
    accion_dialog: {
        type: Number,
        default: 0,
    },
});

const { oTipoDocumento, limpiarTipoDocumento } = useTipoDocumentos();
const { axiosGet } = useAxios();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
let form = useForm(oTipoDocumento.value);
const listTipoDocumentos = ref([]);
const listClientes = ref([]);
const generado = ref(false);
watch(
    () => props.open_dialog,
    async (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oTipoDocumento.value);
            cargarListas();
        }
    }
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
    }
);

const { flash, auth } = usePage().props;

const tituloDialog = computed(() => {
    return accion.value == 0
        ? `<i class="fa fa-plus"></i> Nuevo Reporte Financiero`
        : `<i class="fa fa-edit"></i> Editar Reporte Financiero`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("tipo_documentos.store")
            : route("tipo_documentos.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: () => {
            dialog.value = false;
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            limpiarTipoDocumento();
            emits("envio-formulario");
        },
        onError: (err) => {
            console.log("ERROR");
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
        },
    });
};

const emits = defineEmits(["cerrar-dialog", "envio-formulario"]);

const cargarListas = () => {
    getTipoDocumentos();
    getClientes();
};

const getTipoDocumentos = async () => {
    axios.get(route("tipo_documentos.listado")).then((response) => {
        listTipoDocumentos.value = response.data.tipo_documentos;
    });
};

const getClientes = async () => {
    axios.get(route("clientes.listado")).then((response) => {
        listClientes.value = response.data.clientes;
    });
};

const archivo1 = ref(null);
const archivo2 = ref(null);

const cargarArchivo1 = (event) => {
    archivo1.value = event.target.files[0];
    form.doc1 = archivo1.value;
};
const cargarArchivo2 = (event) => {
    archivo2.value = event.target.files[0];
    form.doc2 = archivo2.value;
};

const getResultado = () => {
    const formData = new FormData();
    formData.append("archivo1", archivo1.value);
    formData.append("archivo2", archivo2.value);
    axios
        .post(route("reporte_financieros.archivos"), formData, {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        })
        .then((response) => {
            console.log(response.data);
        });
};

watch(dialog, (newVal) => {
    if (!newVal) {
        emits("cerrar-dialog");
    }
});

const cerrarDialog = () => {
    dialog.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

onMounted(() => {});
</script>

<template>
    <div
        class="modal fade"
        :class="{
            show: dialog,
        }"
        id="modal-dialog-form"
        :style="{
            display: dialog ? 'block' : 'none',
        }"
    >
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h4 class="modal-title" v-html="tituloDialog"></h4>
                    <button
                        type="button"
                        class="btn-close"
                        @click="cerrarDialog()"
                    ></button>
                </div>
                <div class="modal-body">
                    <form @submit.prevent="enviarFormulario()">
                        <div class="row">
                            <div class="col-12">
                                <small class="text-muted"
                                    >Todos los campos con
                                    <span class="text-danger">(*)</span> son
                                    obligatorios</small
                                >
                            </div>
                            <div class="col-md-6 mt-2">
                                <label class="required"
                                    >Seleccionar Tipo de Documento</label
                                >
                                <el-select
                                    class="w-100"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.tipo_documento_id,
                                    }"
                                    v-model="form.tipo_documento_id"
                                    filterable
                                    placeholder="- Seleccione -"
                                    no-data-text="Sin datos"
                                >
                                    <el-option
                                        v-for="item in listTipoDocumentos"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="item.nombre"
                                    ></el-option>
                                </el-select>
                                <ul
                                    v-if="form.errors?.tipo_documento_id"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.tipo_documento_id }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6 mt-2">
                                <label class="required"
                                    >Seleccionar Cliente</label
                                >
                                <el-select
                                    class="w-100"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.cliente_id,
                                    }"
                                    v-model="form.cliente_id"
                                    filterable
                                    placeholder="- Seleccione -"
                                    no-data-text="Sin datos"
                                >
                                    <el-option
                                        v-for="item in listClientes"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="item.full_name"
                                    ></el-option>
                                </el-select>
                                <ul
                                    v-if="form.errors?.cliente_id"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.cliente_id }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6 mt-2">
                                <label class="required">Cargar Archivo 1</label
                                ><br />
                                <input
                                    type="file"
                                    ref="archivo1"
                                    accept=".xls,.xlsx"
                                    @change="cargarArchivo1"
                                />
                            </div>
                            <div class="col-md-6 mt-2">
                                <label class="required">Cargar Archivo 2</label
                                ><br />
                                <input
                                    type="file"
                                    ref="archivo2"
                                    accept=".xls,.xlsx"
                                    @change="cargarArchivo2"
                                />
                            </div>
                            <div class="col-12 mt-3 text-center">
                                <label class="h4">Resultado</label>
                                <br /><span
                                    class="text-md"
                                    v-text="form.res ?? 'S/R'"
                                ></span>
                            </div>
                            <div class="col-12 text-center">
                                <button
                                    class="btn btn-outline-success"
                                    type="button"
                                    @click="getResultado"
                                >
                                    Generar <i class="fa fa-arrow-right"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <a
                        href="javascript:;"
                        class="btn btn-white"
                        @click="cerrarDialog()"
                        ><i class="fa fa-times"></i> Cerrar</a
                    >
                    <button
                        type="button"
                        @click="enviarFormulario()"
                        class="btn btn-primary"
                        :disabled="!generado"
                    >
                        <i class="fa fa-save"></i>
                        Guardar
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>
