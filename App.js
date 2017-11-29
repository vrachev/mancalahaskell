import React, { Component } from 'react';
import './App.css';

class App extends Component {
  handleClick(buttonNum){
    console.log(buttonNum)
  }

  render() {
    return (
      <div className="board">

        <div className="home">
          {this.props.board[0]}
        </div>
        <div className="holes-section">

          <div className="holes-container">
            <button className = "hole" onClick = {()=>this.handleClick(13)}>{this.props.board[13]}</button>
            <div className = "hole" onClick = {()=>this.handleClick(12)}>{this.props.board[12]}</div>
            <div className = "hole" onClick = {()=>this.handleClick(11)}>{this.props.board[11]}</div>
            <div className = "hole" onClick = {()=>this.handleClick(10)}>{this.props.board[10]}</div>
            <div className = "hole" onClick = {()=>this.handleClick(9)}>{this.props.board[9]}</div>
            <div className = "hole" onClick = {()=>this.handleClick(8)}>{this.props.board[8]}</div>
          </div>



        </div>

        <div className="home">
          { this.props.board[7] }
        </div>


      </div>
    );
  }
}

export default App;
