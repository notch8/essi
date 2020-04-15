import React, { Component } from "react"
import PropTypes from "prop-types"

// jshint esversion: 6

class ReactMessages extends React.Component {
  sendMessage (e, type) {
    e.preventDefault();
    window.flash_messages.addMessage({ id: Date.now(), text: this.props.message, type: type });
  }

  render () {
    return (
      <ul className='nav nav-list'>
        <li className='nav-header'> <img src='/images/react.png'/> React </li>
        <li><a href='#' onClick={ (e) => this.sendMessage(e, 'success') }> Success </a></li>
        <li><a href='#' onClick={ (e) => this.sendMessage(e, 'notice') }> Info </a></li>
        <li><a href='#' onClick={ (e) => this.sendMessage(e, 'alert') }> Warning </a></li>
        <li><a href='#' onClick={ (e) => this.sendMessage(e, 'error') }> Error </a></li>
      </ul>
    );
  }
}

ReactMessages.propTypes = {
  message: React.PropTypes.string
}

ReactMessages.defaultProps = {
  message: 'Hello from React!'
}

export default ReactMessages
