import React, { Component } from "react"
import Form from './form'
import { saveData } from '../shared/save_data'
//import { css } from "@emotion/core";
//import ClipLoader from "react-spinners/ClipLoader";

//const override = css`
//  display: block;
//  margin: 0 auto;
//  border-color: red;
//`;

function processForm(schema, uiSchema, formData) {
  let newSchema = JSON.parse(JSON.stringify(schema))
  let newFormData = JSON.parse(JSON.stringify(formData))
  newSchema.properties.properties.additionalProperties.properties.available_on.properties.class.items.enum = Object.getOwnPropertyNames(formData.classes)
  newSchema.properties.properties.additionalProperties.properties.available_on.properties.context.items.enum = Object.getOwnPropertyNames(formData.contexts)

    return {
        schema: newSchema,
        uiSchema: uiSchema,
        formData: newFormData
    };
}

class M3ProfileForm extends Component {
  constructor(props) {

    super(props)
    let values = processForm(props.schema, {}, props.m3_profile.profile)
    this.state = {
      m3_profile: props.m3_profile,
      formData: values.formData,
      schema: values.schema,
      uiSchema: values.uiSchema,
      isLoading: false,
    }
    this.handleChange = this.handleChange.bind(this)
    this.onFormSubmit = this.onFormSubmit.bind(this)
  }

  handleChange = (data) => {
    const schema = { ...this.state.schema };
    const uiSchema = { ...this.state.uiSchema };
    const { formData } = data;

    const newState = processForm( schema, uiSchema, formData);

    this.setState(newState);
  }

  onFormSubmit = ({formData}) => {
    console.log("SUBMITTED")
    $(":submit").attr("disabled", true)
    this.setState({ isLoading: true })
    
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
          this.setState({ isLoading: false })
          window.scrollTo({ top: 0, behavior: 'smooth' })
          window.location.href = index_path
        } else {
          window.flash_messages.addMessage({ id: 'id', text: 'There was an error saving your information', type: 'danger' });
          this.setState({ isLoading: false })
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
      //<div className="sweet-loading">
      //  <ClipLoader
      //    css={override}
      //    size={150}
      //    color={"#123abc"}
      //    loading={true}
      //  />
      //</div>
      <div>
        <Form key={ this.state.m3_profile.id }
          schema={ this.state.schema }
          formData={this.state.formData}
          uiSchema= {this.state.uiSchema}
          onChange={this.handleChange}
          onSubmit={ this.onFormSubmit }
          onFormError={this.onFormError}
          showErrorList={ false }
        />
        {this.state.isLoading ? "Loading..." : "OK"}
      </div>
    )
  }
}

export default M3ProfileForm
