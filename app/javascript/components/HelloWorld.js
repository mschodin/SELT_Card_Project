import React from "react"
import PropTypes from "prop-types"
import {MDCTopAppBar} from '@material/top-app-bar'

class HelloWorld extends React.Component {
  render () {
    return (
      <React.Fragment>
        <MDCTopAppBar>

        </MDCTopAppBar>
        Greeting: {this.props.greeting}
      </React.Fragment>
    );
  }
}

HelloWorld.propTypes = {
  greeting: PropTypes.string
};
export default HelloWorld
