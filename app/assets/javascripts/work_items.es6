export default class WorkItems {
  constructor() {
    this.toggle_show_items()
  }

  toggle_show_items(){
    let button = $("#work-items-button")
    let show = I18n.t('hyrax.works.form.show_child_items')
    let hide = I18n.t('hyrax.works.form.hide_child_items')
    button.click(function(event) {
      if(button.text() == show){
        button.text(hide)
      }else{
        button.text(show)
      }
    })
  }
}
