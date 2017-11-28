import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {
  handleClick1(){
    console.log("click happened")
  }

  render() {
    return (
      <div>
        <div>full array: {this.props.board}</div>
        <button onClick = {this.handleClick1.bind(this)}></button>
      </div>
    );
  }
}

export default App;
