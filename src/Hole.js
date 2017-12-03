import React, { Component } from 'react';
import './App.css';

class Hole extends Component{

  render() {
    return (
      <button className = "hole"
        disabled = {this.props.disable}
        onClick = {this.props.handleClick}>
        {this.props.stones}
      </button>
    );
 }
}

export default Hole;
