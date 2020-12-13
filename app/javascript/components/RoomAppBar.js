import React from "react"
import PropTypes from "prop-types"
import AppBar from '@material-ui/core/AppBar'
import {Typography} from "@material-ui/core";
import Toolbar from "@material-ui/core/Toolbar";
import IconButton from "@material-ui/core/IconButton";
import {CasinoRounded, ExitToApp, MouseRounded} from "@material-ui/icons";
import theme from "../styles/theme";
import {ThemeProvider} from "@material-ui/styles";
import Button from "@material-ui/core/Button";
import Grid from "@material-ui/core/Grid";
import Menu from "@material-ui/core/Menu";
import MenuItem from "@material-ui/core/MenuItem";

class RoomAppBar extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            setAnchorEl: false,
            anchorMenu: false
        }
        this.handleLeaveGame = this.handleLeaveGame.bind(this);
        this.handleMenuClick = this.handleMenuClick.bind(this);
        this.handleMenuClose = this.handleMenuClose.bind(this);
        this.handleEndGame = this.handleEndGame.bind(this);
    }

    async handleLeaveGame(e) {
        e.preventDefault();
        console.log(this.state);
        let leave_url = '/room/' + this.props.room_id + '/leave';
        fetch(leave_url, {
            method: 'get',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'text/html, application/json, application/xhtml+xml, application/xml'
            },
        }).then((response) => {
            window.location.href = response.url
        })
    }

    async handleEndGame(e) {
        e.preventDefault();
        console.log(this.state);
        let end_url = '/room/' + this.props.room_id + '/destroy'
        fetch(end_url, {
            method: 'get',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'text/html, application/json, application/xhtml+xml, application/xml'
            },
        }).then((response) => {
            window.location.href = response.url
        })
    }

    async handleMenuClick(e) {
        this.setState({['anchorMenu']: e.currentTarget});
    };

    async handleMenuClose(e) {
        this.setState({['anchorMenu']: null});
    };


    render() {
        return (
            <React.Fragment>
                <AppBar position="relative" style={{margin: 0}}>
                    <Toolbar className={"toolbarStyle"}>
                        <Grid container spacing={3}>
                            <Grid item xs={5} className="greetingStyle">
                                <IconButton edge="start" color="inherit">
                                    <MouseRounded/>
                                    <CasinoRounded/>
                                </IconButton>
                                <Typography variant="h5">
                                    {this.props.greeting}
                                </Typography>
                            </Grid>
                            <Grid item xs={4} className="greetingStyle">
                                <Typography variant="h5">
                                    Room Code: {this.props.room_passcode}
                                </Typography>
                            </Grid>
                            <Grid item className="leaveButtonStyle">
                                <Button aria-label="simple-menu" aria-haspopup="true" onClick={this.handleMenuClick}>
                                    <ExitToApp style={{color: "white"}}/>
                                </Button>
                                <Menu
                                    id="simple-menu"
                                    anchorEl={this.state.anchorMenu}
                                    keepMounted
                                    open={Boolean(this.state.anchorMenu)}
                                    onClose={this.handleMenuClose}
                                >
                                    <MenuItem type="submit" onClick={this.handleLeaveGame}>Leave Game</MenuItem>
                                    <MenuItem type="submit" onClick={this.handleEndGame}>End Game</MenuItem>
                                </Menu>
                            </Grid>
                        </Grid>
                    </Toolbar>
                </AppBar>
            </React.Fragment>
        );
    }
}

RoomAppBar.propTypes = {
    greeting: PropTypes.string,
    room_passcode: PropTypes.string,
    room_id: PropTypes.number,
};
export default RoomAppBar
