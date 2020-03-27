import React, { Component } from 'react'
import Form from './form'

const schema = {
  title: "Class",
  type: "object",
  required: ["title"],
  properties: {
    title: {type: "string", title: "Title", default: "A new task"},
    done: {type: "boolean", title: "Done?", default: false}
  }
};

const log = (type) => console.log.bind(console, type);

export default class TextForm extends Component {

  render() {
    return (
      <Form schema={schema}
      onChange={log("changed")}
      onSubmit={log("submitted")}
      onError={log("errors")} />
    );
  }
}
