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
    const index_path = "/dashboard/my/m3_profiles/"
    saveData({
      path: index_path,
      method: "POST",
      data: formData,
      schema: this.state.schema,
      success: (res) => {
        if (res.success) {
          window.scrollTo({ top: 0, behavior: 'smooth' })
          window.flash_messages.addMessage({ id: 'id', text: res.message, type: 'success' });
          window.location.href = index_path

        } else {
          window.flash_messages.addMessage({ id: 'id', text: res.message, type: 'danger' });
        }
      },
      fail: (res) => {
        let message = res.message ? res.message : 'There was an error saving your information'
        window.scrollTo({ top: 0, behavior: 'smooth' })
        window.flash_messages.addMessage({ id: 'id', text: message, type: 'danger' });
      }
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
        />
      </div>
    )
  }
}

export default M3ProfileForm
