import React from "react";
import Button from '@material-ui/core/Button';
import Typography from "@material-ui/core/Typography";
import { TextField, InputAdornment, IconButton } from "@material-ui/core";
import Visibility from "@material-ui/icons/Visibility";
import VisibilityOff from "@material-ui/icons/VisibilityOff";
import Box from "@material-ui/core/Box";
import Grid from "@material-ui/core/Grid";
import HomeAppBar from "./HomeAppBar";
import { createMuiTheme, ThemeProvider } from "@material-ui/core";
import "fontsource-roboto"

const theme = createMuiTheme({
    palette: {
        primary: {
            main: "#00695c"// blueish
        },
        secondary: {
            main: "#aed581" // greenish
        }
    },
    fontFamily: "Roboto",
    fontVariant: 'all-small-caps'
});

export default class Home extends React.Component {
     // Add these variables to your component to track the state
    constructor(props) {
        super(props);
        this.state = {
            showPassword: false,
            setShowPassword: false,
            name: '',
            room_code: '',
            room_id: null,
            room_code_problem: false
        };
        this.handleClickShowPassword = this.handleClickShowPassword.bind(this);
        this.handleMouseDownPassword = this.handleMouseDownPassword.bind(this);
        this.handlePassword = this.handlePassword.bind(this);
        this.handleName = this.handleName.bind(this);
        this.handleRoomID = this.handleRoomID.bind(this);
    }
    async handleClickShowPassword(){ this.setState({
        showPassword: !this.state.showPassword
    })};
    async handleMouseDownPassword(){ this.setState({
        showPassword: !this.state.showPassword
    })};
    async handlePassword(event){
        let newPasscode = event.target.value;
        await this.setState({
            room_code: newPasscode,
            room_code_problem: false
        });}
    async handleName(event){
        let newName = event.target.value;
        await this.setState({
            name: newName,
        });}
    async handleRoomID(event){
        let newRoomID = event.target.value;
        await this.setState({
            room_id: newRoomID,
        });}

    render() {
        return(
            <ThemeProvider theme={theme}>
            <div>
            <React.Fragment>
                <HomeAppBar/>
                <Grid justify="space-evenly" alignItems="center" container spacing={1}>
                    <Grid item>
                    <Box pb={1} pt={3}>
                        <Typography variant={"h5"}>Create Game</Typography>
                        <Box pb={1} pt={1}>
                            <form className='formStyle'>
                                <Box pb={1} pt={1}>
                                    <TextField type= 'text'
                                               variant='outlined'
                                               id="name"
                                               placeholder= 'Enter Name' />
                                </Box>
                                <Box pb={1} pt={1}>
                                    <Button fullwidth variant="contained" color='secondary' type='submit'>Create Game</Button>
                                </Box>
                            </form>
                        </Box>
                        <Box pb={1} pt={5}>
                            <Typography variant={"h5"}>Join Game</Typography>
                            <form className='formStyle'>
                                <Box pb={1} pt={1}>
                                <TextField type= 'text'
                                           variant='outlined'
                                           id="name"
                                           onChange={this.handleName}
                                           placeholder= 'Enter Name' />
                                </Box>
                                <Box pb={1} pt={1}>
                                <TextField type= 'text'
                                           variant='outlined'
                                           id="room_id"
                                           onChange={this.handleRoomID}
                                           placeholder= 'Enter Room #'/>
                                </Box>
                                <TextField
                                   variant='outlined'
                                   id="room_code"
                                   placeholder= 'Enter Room Passcode'
                                   onChange={this.handlePassword}
                                   type={this.state.showPassword ? "text" : "password"} // <-- This is where the magic happens
                                   InputProps={{ // <-- This is where the toggle button is added.
                                       endAdornment: (
                                           <InputAdornment position="end">
                                               <IconButton
                                                   aria-label="toggle password visibility"
                                                   onClick={this.handleClickShowPassword}
                                                   onMouseDown={this.handleMouseDownPassword}
                                               >
                                                   {this.state.showPassword ? <Visibility /> : <VisibilityOff />}
                                               </IconButton>
                                           </InputAdornment>
                                       )
                                   }}
                                />
                                <Box pb={1} pt={1}>
                                    <Button fullwidth value="Post" variant="contained" color='secondary' type='submit'>Join Game</Button>
                                </Box>
                         </form>
                        </Box>
                    </Box>
                    </Grid>
                </Grid>
            </React.Fragment>
            </div>
            </ThemeProvider>
        );
    }
}