import React, { Component } from 'react'
import Form from './form'

const schema = {
  title: "Class Definitions",
  type: "object",
  required: ["name", "displayLabel"],
  properties: {
    name: {type: "string", title: "Name", default: "A new name"},
    displayLabel: {type: "string", title: "Display Label", default: "A new label"},
  }
};

const log = (type) => console.log.bind(console, type);

export default class ClassForm extends Component {

  render() {
    return (
      <Form schema={schema}
      onChange={log("changed")}
      onError={log("errors")} />
    );
  }
}