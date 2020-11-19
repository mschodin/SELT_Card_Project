import React from "react"
import PropTypes from "prop-types"
import AppBar from '@material-ui/core/AppBar'
import {Typography} from "@material-ui/core";
class RoomAppBar extends React.Component {
  render () {
    return (
      <React.Fragment>
        <AppBar>
         <Typography>
           {this.props.greeting}
         </Typography>
        </AppBar>
      </React.Fragment>
    );
  }
}

RoomAppBar.propTypes = {
  greeting: PropTypes.string
};
export default RoomAppBar
