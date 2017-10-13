import React, { Component } from "react";
import axios from "axios";

class Pong extends Component {
  state = {
    post: {}
  }

  componentDidMount() {
    this.fetchPost()
  }

  fetchPost() {
    return (
      axios
        .get('https://jsonplaceholder.typicode.com/posts/1')
        .then(res => this.setState({ post: res.data }))
        .catch(error => console.warn(error))
    );
  }

  render() {
    return <span />;
  }
}

export default Pong;
