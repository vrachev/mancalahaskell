import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';

const board = [4,4,4,4,4,4,4,4,4,4,4,4];
ReactDOM.render(<App board = {board}/>, document.getElementById('root'));
registerServiceWorker();
