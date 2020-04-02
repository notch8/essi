import React, { Component, useState } from "react";
import M3ProfileForm from "./m3_profile_form";

class CustomForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      //schema: props.m3_profile.schema
    };
  }


  render() {
    return (
      <div>
        <M3ProfileForm key={0}
          //section={section}
          //data={state.formData[section.key]}
          //dispatch={dispatch} />
        />
        <button className="btn btn-info" onClick={this.onFormSubmit}>
          Submit
        </button>
      </div>
    )
  }
}

export default CustomForm


