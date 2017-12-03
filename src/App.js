import React, { Component } from 'react';
import './App.css';
import Hole from './Hole.js';

class App extends Component {
  constructor(props){
    super(props);
    //use this.setState everywhere else
    this.state = {player: this.props.player}
  }
  handleClick(num, e){
    this.setState({player: (this.state.player == 1 ? 2 : 1)})
  }


//maybe put a box on either side of board that says "p1" and "p2"
  render() {

    return (
      <div>
        <div className="messagePanel">Player {this.state.player}'s turn</div>
        <div className="board">
          <div className="home">
            {this.props.board[0]}
          </div>
          <div className="holes-section">
            <div className="holes-container">
              <Hole disable = {this.state.player === 2} handleClick = {(e)=>this.handleClick(13, e)} stones = {this.props.board[13]}/>
              <Hole disable = {this.state.player === 2} handleClick = {(e)=>this.handleClick(12, e)} stones = {this.props.board[12]}/>
              <Hole disable = {this.state.player === 2} handleClick = {(e)=>this.handleClick(11, e)} stones = {this.props.board[11]}/>
              <Hole disable = {this.state.player === 2} handleClick = {(e)=>this.handleClick(10, e)} stones = {this.props.board[10]}/>
              <Hole disable = {this.state.player === 2} handleClick = {(e)=>this.handleClick(9, e)} stones = {this.props.board[9]}/>
              <Hole disable = {this.state.player === 2} handleClick = {(e)=>this.handleClick(8, e)} stones = {this.props.board[8]}/>
            </div>
            <div className="holes-container">
              <Hole disable = {this.state.player === 1} handleClick = {(e)=>this.handleClick(1, e)} stones = {this.props.board[1]}/>
              <Hole disable = {this.state.player === 1} handleClick = {(e)=>this.handleClick(2, e)} stones = {this.props.board[2]}/>
              <Hole disable = {this.state.player === 1} handleClick = {(e)=>this.handleClick(3, e)} stones = {this.props.board[3]}/>
              <Hole disable = {this.state.player === 1} handleClick = {(e)=>this.handleClick(4, e)} stones = {this.props.board[4]}/>
              <Hole disable = {this.state.player === 1} handleClick = {(e)=>this.handleClick(5, e)} stones = {this.props.board[5]}/>
              <Hole disable = {this.state.player === 1} handleClick = {(e)=>this.handleClick(6, e)} stones = {this.props.board[6]}/>
            </div>
          </div>
          <div className="home">
            { this.props.board[7] }
          </div>
        </div>
      </div>
    );
  }
}

export default App;
