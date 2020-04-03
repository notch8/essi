import React, { Component } from "react"
import Form from './form'
import { saveData } from '../shared/save_data'

//const schema = {
//  "$schema": "http://json-schema.org/draft-07/schema#",
//  "$id": "http://example.com/m3_json_schema.json",
//  "type": "object",
//  "title": "The M3 JSON Schema",
//  "comment": "profile, classes and properties are required; contexts and mappings are not",
//  "required": [
//    "m3_version",
//    "profile",
//    "classes",
//    "properties"
//  ],
//  "properties": {
//
//    "m3_version": {
//      "$id": "#/properties/m3_version",
//      "type": "string",
//      "title": "Schema Version",
//      "description": "Version number for the M3 specification. Change this to make a new release. Instances will be validated to check they have this version in place.",
//      "pattern": "1.0.beta2"
//    },
//
//    "profile": {
//      "$id": "#/properties/profile",
//      "type": "object",
//      "title": "Profile Information",
//      "description": "Administrative information about the profile or model defined in the file.",
//      "additionalProperties": false,
//      "required": [
//        "responsibility",
//        "date_modified"
//      ],
//      "properties": {
//        "responsibility": {
//          "$id": "#/properties/profile/responsibility",
//          "title": "Responsiblity",
//          "description": "uri for the organization or individual responsible for maintaining the profile",
//          "type": "string",
//          "format": "uri",
//          "examples": [
//            "https://wiki.duraspace.org/display/samvera/Samvera+Metadata+Interest+Group"
//          ]
//        },
//        "responsibility_statement": {
//          "$id": "#/properties/profile/responsibility_statement",
//          "title": "Reponsibility Statement",
//          "description": "statement of the organization or individual responsible for maintaining the profile",
//          "type": "string",
//          "examples": [
//            "Samvera Metadata Interest Group"
//          ]
//        },
//        "date_modified": {
//          "$id": "#/properties/profile/date_modified",
//          "title": "Date Modified",
//          "description": "the date the profile was last altered",
//          "type": "string",
//          "format": "date",
//          "comment": "In YAML, dates must be wrapped in quotes to be validated by json schema",
//          "examples": [
//            "2019-07-03"
//          ]
//        },
//        "profile_type": {
//          "$id": "#/properties/profile/type",
//          "title": "Type",
//          "description": "type of thing does the profile describe",
//          "type": "string",
//          "examples": [
//            "metadata models"
//          ]
//        },
//        "profile_version": {
//          "$id": "#/properties/profile/version",
//          "title": "Version",
//          "description": "version of the profile",
//          "type": "number",
//          "examples": [
//            0.8
//          ]
//        }
//      }
//    },
//    "classes": {
//      "$id": "#/properties/classes",
//      "type": "object",
//      "title": "Class Definitions",
//      "description": "Definition of the classes used in the profile. Classes should be provided with a generic local name for the class, in CamelCase.",
//      "comment": "Class names are pattern matched.",
//      "additionalProperties": {
//        "type": "object",
//        "required": ["display_label"],
//        "properties": {
//          "name": {
//            "type": "string",
//            "title": "Name",
//            "description": "Enter a name for this class."
//          },
//          "schema_uri": {
//            "type": "string",
//            "title": "Schema URI",
//            "format": "uri",
//            "description": "URI for the class, from a local or shared ontology."
//          },
//          "display_label": {
//            "type": "string",
//            "title": "Display Label",
//            "description": "Human-readable label for the class.",
//            "comment": "For classes, display label is a string.",
//            "examples": [
//              "Generic Work"
//            ]
//          },
//          "contexts": {
//            "type": "array",
//            "title": "Context",
//            "items": { "type": "string" },
//            "description": "A list of contexts in which this class may be used. Empty is taken to indicate all contexts.",
//            "comment": "Contexts must match a context defined in the contexts block.",
//            "examples": [
//              ["chem"]
//            ]
//          }
//        }
//      },
//      "propertyNames": {
//        "pattern": "^[a-zA-Z]*$"
//      },
//      "examples": [
//        {
//          "GenericWork": {
//            "display_label": "Generic Work"
//          }
//        },
//        {
//          "Collection": {
//            "display_label": "Collection"
//          }
//        },
//        {
//          "Agent": {
//            "display_label": "Agent",
//            "schema_uri": "http://id.loc.gov/ontologies/bibframe/Agent"
//          }
//        }
//      ]
//    },
//    "contexts": {
//      "$id": "#/properties/contexts",
//      "type": "object",
//      "title": "Context Definitions",
//      "description": "Definition of the contexts used in the profile. Contexts should be provided with a stable generic local name for the context. Names must be lower case alpha characters separated with underscores.",
//      "comment": "Context names are pattern matched.",
//      "additionalProperties": {
//        "type": "object",
//        "required": ["name", "display_label"],
//        "properties": {
//          "name": {
//            "type": "string",
//            "title": "Name",
//            "description": "Enter a name for this context."
//          },
//          "display_label": {
//            "type": "string",
//            "title": "Display Label",
//            "description": "Human-readable label for the context.",
//            "comment": "For contexts, display label is a string.",
//            "examples": [
//              "Department of Chemistry"
//            ]
//          }
//        }
//      },
//      "propertyNames": {
//        "pattern": "^[a-z_]*$"
//      },
//      "examples": [
//        {
//          "chem": {
//            "display_label": "Department of Chemistry"
//          }
//        }
//      ]
//    },
//    "properties": {
//      "$id": "#/properties/properties",
//      "type": "object",
//      "title": "Property Definitions",
//      "description": "Definition of the properties used in the model. Properties should be provided with a stable generic local name for the property. Names must be lower case alpha characters separated with underscores.",
//      "comment": "Property names pattern matched.",
//      "propertyNames": {
//        "pattern": "^[a-z_]*$"
//      },
//      "additionalProperties": {
//        "type": "object",
//        "items": {
//          "type": "string"
//        },
//        "required": ["name", "display_label"],  
//        "properties": {
//          "name": {
//            "type": "string",
//            "title": "Name",
//            "description": "Enter a name for this property."
//          },
//          "property_uri": {
//            "type": "string",
//            "title": "Property URI",
//            "format": "uri",
//            "description": "URI for the property, from a local or shared ontology.",
//            "examples": [
//              "http://purl.org/dc/elements/1.1/creator"
//            ]
//          },
//          "available_on": {
//            "type": "object",
//            "title": "Available On:",
//            "items": {
//              "type": "string"
//            },
//            "description": "The classes (objects and/or work types) or contexts this property is available on (defined in 'classes' or 'contexts' section.)",
//            "properties": {
//              "class": {
//                "comment": "Listed values must match a class defined in the classes block.",
//                "type": "array",
//                "title": "Classes",
//                "items": {"type": "string"}
//              },
//              "context": {
//                "comment": "Listed values must match a context defined in the contexts block.",
//                "type": "array",
//                "title": "Contexts",
//                "items": {"type": "string"}
//              }
//            },
//            "examples": [
//              {
//                "class": [
//                  "Collection",
//                  "MyCustomWorkType"
//                ],
//                "context": [
//                  "chem"
//                ]
//              }
//            ]
//          },
//          "cardinality": {
//            "type": "object",
//            "title": "Cardinality",
//            "description": "System cardinality and obligation.",
//            "properties": {
//              "minimum": {
//                "type": "integer",
//                "title": "Minimum",
//                "description": "Minimum number of values the property must have.  If there is no value provided, the assumed default minimum is 0.",
//                "default": 0,
//                "examples": [
//                  1
//                ]
//              },
//              "maximum": {
//                "type": "integer",
//                "title": "Maximum",
//                "description": "Maximum number of values the property may have.  If there is no value provided, the assumed default maximum is unlimited.",
//                "default": 100,
//                "examples": [
//                  5
//                ]
//              }
//            },
//            "examples": [
//              {
//                "cardinality": {
//                  "minimum": 0,
//                  "maximum": 100
//                }
//              }
//            ]
//          },
//          "indexing": {
//            "type": "array",
//            "title": "Indexing",
//            "description": "a list of dynamic field names, taken from a controlled list; commonly used values are _tesim (stored searchable text), _teim (searchable text), _sim (string facetable), _ssm (string displayable)",
//            "items": {
//              "type": "string",
//              "enum": [
//                "displayable",
//                "facetable",
//                "searchable",
//                "sortable",
//                "stored_searchable",
//                "stored_sortable",
//                "symbol",
//                "fulltext_searchable"
//              ]
//            },
//            "examples": [
//              ["_tesim", "_sim"]
//            ]
//          }
//        }
//      }
//    }
//  }
//}

class M3ProfileForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      m3_profile: props.m3_proile,
      schema: props.schema,
      msg: "",
      //schema: props.m3_profile.schema || schema
    };
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
      success: (res) => {
        if (res.success) {
          this.setState({ msg: res.message, type: 'success' })
        } else {
          this.setState({ msg: `${res.message} -- ${res.errors.join(', ')}`, type: 'danger' })
        }
        window.scrollTo({ top: 0, behavior: 'smooth' })
      },
      fail: (res) => {
        var message = res.message ? res.message : 'There was an error saving your information'
        this.setState({ msg: message, type: 'danger' })
        window.scrollTo({ top: 0, behavior: 'smooth' })
      }
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
