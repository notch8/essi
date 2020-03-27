import React, { Component } from "react";
import ClassForm from './class_form'
import ContextForm from './context_form'
import PropertyForm from './property_form'

export default class M3ProfileForm extends Component {

  render() {
    return [
      <ClassForm
      />,
      <ContextForm
      />,
      <PropertyForm
      />
    ];
  }
}
