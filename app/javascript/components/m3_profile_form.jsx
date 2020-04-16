import React, { Component } from "react"
import Form from './form'
import { saveData } from '../shared/save_data'

class M3ProfileForm extends Component {
  constructor(props) {
    super(props)
    this.state = {
      m3_profile: props.m3_profile,
      formData: props.m3_profile.profile,
      schema: props.schema,
    }
    this.onFormSubmit = this.onFormSubmit.bind(this)
  }

  onFormSubmit = ({formData}) => {
    console.log("SUBMITTED")
    $(":submit").attr("disabled", true)
    const index_path = "/dashboard/my/m3_profiles/"

    saveData({
      path: index_path,
      method: "POST",
      data: formData,
      schema: this.state.schema,
      success: (res) => {
        let statusCode = res.status
        if (statusCode == 200) {
          window.flash_messages.addMessage({ id: 'id', text: 'A new profile version has been saved!', type: 'success' });
          window.scrollTo({ top: 0, behavior: 'smooth' })
          window.location.href = index_path
        } else {
          window.flash_messages.addMessage({ id: 'id', text: 'There was an error saving your information', type: 'danger' });
          window.scrollTo({ top: 0, behavior: 'smooth' })
        }
      },
      //fail: (res) => {
      //  let message = res.message ? res.message : 'There was an error saving your information'
      //  window.flash_messages.addMessage({ id: 'id', text: message, type: 'danger' });
      //  window.scrollTo({ top: 0, behavior: 'smooth' })
      //}
    })
  }

  onFormError = (data) => {
    console.log('Error', data)
  }

  render() {
    return (
      <div>
        <Form key={ this.state.m3_profile.id }
          schema={ this.state.schema }
          formData={this.state.formData}
          onSubmit={ this.onFormSubmit }
          onFormError={this.onFormError}
          showErrorList={ false }
        />
      </div>
    )
  }
}

export default M3ProfileForm
