import React, { Component } from 'react'
import Form from './form'

const schema = {
  title: "Context Definitions",
  type: "object",
  required: ["name"],
  properties: {
    name: {type: "string", title: "Name", default: "A new name"},
    displayLabel: {type: "string", title: "Display Label", default: "A new label"},
  }
};

const log = (type) => console.log.bind(console, type);

export default class ContextForm extends Component {

  render() {
    return (
      <Form schema={schema}
      onChange={log("changed")}
      onError={log("errors")} />
    );
  }
}
