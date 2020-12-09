import React from "react"
import PropTypes from "prop-types"
import AppBar from '@material-ui/core/AppBar'
import {Typography} from "@material-ui/core";
import Toolbar from "@material-ui/core/Toolbar";
import IconButton from "@material-ui/core/IconButton";
import {CasinoRounded, MouseRounded} from "@material-ui/icons";
import theme from "../styles/theme";
import {ThemeProvider} from "@material-ui/styles";
class RoomAppBar extends React.Component {
  render () {
    return (
        <ThemeProvider theme={theme}>
            <React.Fragment>
                <AppBar style={{ margin: 0}}>
                    <Toolbar>
                        <IconButton edge="start" color="inherit">
                            <MouseRounded/>
                            <CasinoRounded/>
                        </IconButton>
                        <Typography variant="h4" style={{alignSelf: "center"}}>
                            {this.props.greeting}
                        </Typography>
                    </Toolbar>
                </AppBar>
            </React.Fragment>
        </ThemeProvider>
    );
  }
}

RoomAppBar.propTypes = {
  greeting: PropTypes.string
};
export default RoomAppBar
