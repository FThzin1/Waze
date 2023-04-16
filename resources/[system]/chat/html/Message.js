Vue.component('message', {
  template: '#message_template',
  data() {
    return {};
  },
  computed: {
    textEscaped() {
      let s = this.template ? this.template : this.templates[this.templateId];

      if (this.template) {
        this.templateId = -1;
      }

      if (this.templateId == CONFIG.defaultTemplateId
        && this.args.length == 1) {
        s = this.templates[CONFIG.defaultAltTemplateId]
      }

      s = s.replace(/{(\d+)}/g, (match, number) => {
        const argEscaped = this.args[number] != undefined ? this.escape(this.args[number]) : match
        if (number == 0 && this.color) {
          return this.colorizeOld(argEscaped);
        }
        return argEscaped;
      });
      return this.colorize(s);
    },
  },
  methods: {
    colorizeOld(str) {
      return `<p style="color: rgb(${this.color[0]}, ${this.color[1]}, ${this.color[2]})">${str}</p>`
    },
    colorize(str) {
      let s = (str.replace(/\^([0-9])/g, (str, color) => `<p class="color-${color}">`)) + "</p>";

      const styleRegex = /\^(\_|\*|\=|\~|\/|r)(.*?)(?=$|\^r|<\/em>)/;
      while (s.match(styleRegex)) {
        s = s.replace(styleRegex, (str, style, inner) => `${inner}`)
      }

      return s.replace(/<span[^>]*><\/span[^>]*>/g, '');
    },
    escape(unsafe) {
      return String(unsafe)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#039;');
    },
  },
  props: {
    templates: {
      type: Object,
    },
    args: {
      type: Array,
    },
    template: {
      type: String,
      default: null,
    },
    templateId: {
      type: String,
      default: CONFIG.defaultTemplateId,
    },
    multiline: {
      type: Boolean,
      default: false,
    },
    color: { //deprecated
      type: Array,
      default: false,
    },
  },
});