import React from "react"
import PropTypes from "prop-types"
import AppBar from '@material-ui/core/AppBar'
import {Typography} from "@material-ui/core";
import Toolbar from "@material-ui/core/Toolbar";
import IconButton from "@material-ui/core/IconButton";
import {CasinoRounded, MouseRounded} from "@material-ui/icons";
import theme from "../styles/theme";
import {ThemeProvider} from "@material-ui/styles";
import Button from "@material-ui/core/Button";
class RoomAppBar extends React.Component {

    constructor(props) {
        super(props);
        this.handleLeaveGame = this.handleLeaveGame.bind(this);
    }

    async handleLeaveGame(e){
        e.preventDefault();
        console.log(this.state);
        let leave_url = '/room/'+ this.props.room_id + '/leave';
        fetch(leave_url, {
            method: 'get',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'text/html, application/json, application/xhtml+xml, application/xml'
            },
        }).then((response) => { window.location.href = response.url })
    }
  render () {
    return (
        <ThemeProvider theme={theme}>
            <React.Fragment>
                <AppBar position="relative" style={{ margin: 0}}>
                    <Toolbar className={"toolbarStyle"}>
                        <IconButton edge="start" color="inherit">
                            <MouseRounded/>
                            <CasinoRounded/>
                        </IconButton>
                        <Typography variant="h5" className="greetingStyle">
                            {this.props.greeting}
                        </Typography>
                        <Typography variant="h5" className="roomCodeStyle">
                            {this.props.room_passcode}
                        </Typography>
                        <Button variant="outlined" color='inherit' type='submit' className="leaveButtonStyle" onClick={this.handleLeaveGame}>Leave Game</Button>
                    </Toolbar>
                </AppBar>
            </React.Fragment>
        </ThemeProvider>
    );
  }
}

RoomAppBar.propTypes = {
  greeting: PropTypes.string,
  room_passcode: PropTypes.string,
  room_id: PropTypes.number
};
export default RoomAppBar
