import React from "react";
import Button from '@material-ui/core/Button';
import ThemeProvider from '@material-ui/core/styles';
import Typography from "@material-ui/core/Typography";
import { TextField, InputAdornment, IconButton } from "@material-ui/core";
import Visibility from "@material-ui/icons/Visibility";
import VisibilityOff from "@material-ui/icons/VisibilityOff";
import Box from "@material-ui/core/Box";
import Grid from "@material-ui/core/Grid";
import HomeAppBar from "./HomeAppBar";

class Home extends React.Component {
     // Add these variables to your component to track the state
    constructor(props) {
        super(props);
        this.state = {
            showPassword: false,
            setShowPassword: false,
            name: '',
            passcode: '',
            roomNumber: null
        };
        this.handleClickShowPassword = this.handleClickShowPassword.bind(this);
        this.handleMouseDownPassword = this.handleMouseDownPassword.bind(this);
    }
    async handleClickShowPassword(){ this.setState({
        showPassword: !this.state.showPassword
    })};
    async handleMouseDownPassword(){ this.setState({
        showPassword: !this.state.showPassword
    })};

    render() {
        return(
            <React.Fragment>
                <HomeAppBar/>
                <Grid justify="space-evenly" alignItems="center" container spacing={1}>
                    <Grid item>
                    <Box pb={1} pt={1}>
                        <h3>Create Game</h3>
                        <Box pb={1} pt={1}>
                            <form className='formStyle'>
                                <Box pb={1} pt={1}>
                                    <TextField type= 'text'
                                               variant='outlined'
                                               placeholder= 'Enter Name' />
                                </Box>
                                <Box pb={1} pt={1}>
                                    <Button raised color='primary' type='submit'>Create Game</Button>
                                </Box>
                            </form>
                        </Box>
                        <h3>Join Game</h3>
                        <Box pb={1} pt={1}>
                            <form className='formStyle'>
                                <Box pb={1} pt={1}>
                                <TextField type= 'text'
                                           variant='outlined'
                                           placeholder= 'Enter Name' />
                                </Box>
                                <Box pb={1} pt={1}>
                                <TextField type= 'text'
                                           variant='outlined'
                                           placeholder= 'Enter Room #'/>
                                </Box>
                                <TextField
                                   variant='outlined'
                                   placeholder= 'Enter Room Passcode'
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
                                    <Button raised color='primary' type='submit'>Join Game</Button>
                                </Box>
                         </form>
                        </Box>
                    </Box>
                    </Grid>
                </Grid>
            </React.Fragment>
        );
    }
}
export default Home;