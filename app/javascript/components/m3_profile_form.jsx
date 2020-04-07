import React, { Component } from "react"
import Form from './form'
import { saveData } from '../shared/save_data'

class M3ProfileForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      m3_profile: props.m3_profile,
      formData: props.m3_profile.profile,
      schema: props.schema,
      msg: "",
    };
    this.renderMessage = this.renderMessage.bind(this);
    this.onFormSubmit = this.onFormSubmit.bind(this);
    debugger;
  }

  renderMessage = () => {
    if (this.state.msg.msg) {
      return (
        <div className={'alert alert-' + this.state.msg.type} >
        {this.state.msg.msg}
        </div>
      )
    } else {
      return null
    }
  }

  onFormSubmit = ({formData}) => {
    console.log("SUBMITTED");
    saveData({
      path: "/dashboard/my/m3_profiles/",
      method: "POST",
      data: formData,
      schema: this.state.schema,
     // success: (res) => {
     //   if (res.success) {
     //     this.state.msg = { msg: res.message, type: 'success' }
     //   } else {
     //     this.state.msg = { msg: `${res.message} -- ${res.errors.join(', ')}`, type: 'danger' }
     //   }
     //   window.scrollTo({ top: 0, behavior: 'smooth' }
     // },
     // fail: (res) => {
     //   let message = res.message ? res.message : 'There was an error saving your information'
     //   this.state.msg = { msg: message, type: 'danger' }
     //   window.scrollTo({ top: 0, behavior: 'smooth' })
     // }
    })
  }

  render() {
    return (
      <div>
        { this.renderMessage() }
        <Form key={ this.state.m3_profile.id }
          schema={ this.state.schema }
          //onChange={log("changed")}
          formData={this.state.formData}
          onSubmit={ this.onFormSubmit }
          //onError={log("errors")} 
        />
      </div>
    )
  }
}

export default M3ProfileForm
