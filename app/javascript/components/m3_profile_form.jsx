import React, { Component } from "react"
import Form from './form'
import { saveData } from '../shared/save_data'

class M3ProfileForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      m3_profile: props.m3_proile,
      schema: props.schema,
      msg: "",
      //schema: props.m3_profile.schema || schema
    };
    debugger;
    this.renderMessage = this.renderMessage.bind(this);
    this.onFormSubmit = this.onFormSubmit.bind(this);
  }

  renderMessage = () => {
    if (this.msg.msg) {
      return (
        <div className={'alert alert-' + this.msg.type} >
        {this.msg.msg}
        </div>
      )
    } else {
      return null
    }
  }

  onFormSubmit = ({formData}) => {
    console.log("SUBMITTED");
    saveData({
      path: "http://localhost:4000/dashboard/my/m3_profiles/",
      method: "POST",
      data: formData,
      schema: this.state.schema
    })
  }

  //onSubmit = ({formData}, e) => console.log("Data submitted: ",  formData);

  render() {
    return (
      <div>
        <Form schema={ this.state.schema }
          //onChange={log("changed")}
          //formData={this.state.formData}
          onSubmit={ this.onFormSubmit }
          //onSubmit={this.onSubmit}
          //onError={log("errors")} 
        />
      </div>
    )
  }
}

export default M3ProfileForm
