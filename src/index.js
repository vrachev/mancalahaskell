import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';

var board = [0,4,4,4,4,4,4,0,4,4,4,4,4,4];
var player = 1;
ReactDOM.render(<App board = {board} player = {player}/>, document.getElementById('root'));
registerServiceWorker();
