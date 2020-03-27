import React, { Component } from 'react'
import Form from './form'

const schema = {
  title: "Property Definitions",
  type: "object",
  required: ["name", "indexing"],
  properties: {
    name: {type: "string", title: "Name", default: "A new name"},
    property_uri: {type: "string", title: "Property URI", default: "A new name"},
    cardinality_minimum: {type: "integer", title: "Cardinality Minimum", default: "0"},
    cardinality_maxiumum: {type: "integer", title: "Cardinality Maximum", default: "100"},
    indexing: {type: "select", title: "Indexing", default: "A new label"},
  }
};

const log = (type) => console.log.bind(console, type);

export default class PropertyForm extends Component {

  render() {
    return (
      <Form schema={schema}
      onChange={log("changed")}
      onError={log("errors")} />
    );
  }
}
