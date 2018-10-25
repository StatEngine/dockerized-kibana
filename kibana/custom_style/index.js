
export default function (kibana) {
  return new kibana.Plugin({
   uiExports: {
     app: {
        title: 'custom_style',
        order: -100,
        description: 'Custom Styling',
        main: 'plugins/custom_style/index.js',
        hidden: true
     }
    }
  });
};
