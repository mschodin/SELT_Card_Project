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
import CssBaseline from "@material-ui/core/CssBaseline";
import FlashMessage from "./FlashMessage";
import theme from '../styles/theme'

class Home extends React.Component {
     // Add these variables to your component to track the state
    constructor(props) {
        super(props);
        this.state = {
            showPassword: false,
            setShowPassword: false,
            create_name: "",
            join_name: "",
            room_code: "",
            room_id: "",
            room_code_problem: false,
            submit_enabled: false,
        };
        this.handleClickShowPassword = this.handleClickShowPassword.bind(this);
        this.handleMouseDownPassword = this.handleMouseDownPassword.bind(this);
        this.handlePassword = this.handlePassword.bind(this);
        this.handleChange = this.handleChange.bind(this);
        this.handleCreateFormSubmit = this.handleCreateFormSubmit.bind(this);
        this.handleJoinFormSubmit = this.handleJoinFormSubmit.bind(this);
    }

    async handleCreateFormSubmit(e){
        e.preventDefault();
        console.log(this.state);
        console.log(this.props.room_create)
        let body = JSON.stringify({name: this.state.create_name})
       fetch(this.props.room_create, {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'text/html, application/json, application/xhtml+xml, application/xml'
            },
            body: body,
        }).then((response) => { window.location.href = response.url })
    }

    async handleJoinFormSubmit(e){
        e.preventDefault();
        console.log(this.state)
        console.log(this.props.room_join)
        let body = JSON.stringify(
            { name: this.state.join_name,
                   room_id: this.state.room_id,
                   room_code: this.state.room_code
        })
        fetch(this.props.room_join, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'text/html, application/json, application/xhtml+xml, application/xml'
            },
            body: body,
        }).then((response) => {
            console.log(this.props.flash_message);
            console.log(response);
            window.location.href = response.url
            //window.location.reload(true)
        }).catch(error => {
            console.log(error.response.data.message);
            this.setState({error_message: error.response.data.message});
        })
    }

    async handleClickShowPassword(){ this.setState({
        showPassword: !this.state.showPassword
    })};
    async handleMouseDownPassword(){ this.setState({
        showPassword: !this.state.showPassword
    })};

    handleChange = event => {
        this.setState({ [event.target.name]: event.target.value });
    }
    async handlePassword(event){
        let newPasscode = event.target.value;
        await this.setState({
            room_code: newPasscode,
            room_code_problem: false
        });}

    render() {
        const disable_create = !this.state.create_name.length;
        const disable_join = !(this.state.join_name && this.state.room_code && this.state.room_id);
        return(
            <ThemeProvider theme={theme}>
            <CssBaseline />
            <React.Fragment>
                <HomeAppBar/>
                {!(this.props.flash_message==null)&&(<FlashMessage flash_message={this.props.flash_message}/>)}
                <Grid justify="space-evenly" alignItems="center" container spacing={1}>
                    <Grid item>
                    <Box pb={1} pt={3}>
                        <Typography variant={"h5"}>Create Game</Typography>
                        <Box pb={1} pt={1}>
                            <form className='formStyle' method="post" onSubmit={this.handleCreateFormSubmit} >
                                <Box pb={1} pt={1}>
                                    <TextField type= 'text'
                                               variant='outlined'
                                               name="create_name"
                                               onChange={this.handleChange}
                                               placeholder= 'Enter Name' />
                                </Box>
                                <Box pb={1} pt={1}>
                                    <Button disabled={disable_create} fullwidth={"true"} variant="contained" color='secondary' aria-label='submit' type='submit'>Create Game</Button>
                                </Box>
                            </form>
                        </Box>
                        <Box pb={1} pt={5}>
                            <Typography variant={"h5"}>Join Game</Typography>
                            <form className='formStyle' onSubmit={this.handleJoinFormSubmit}>
                                <Box pb={1} pt={1}>
                                <TextField type= 'text'
                                           variant='outlined'
                                           name="join_name"
                                           onChange={this.handleChange}
                                           placeholder= 'Enter Name' />
                                </Box>
                                <Box pb={1} pt={1}>
                                <TextField type= 'text'
                                           variant='outlined'
                                           name="room_id"
                                           onChange={this.handleChange}
                                           placeholder= 'Enter Room #'/>
                                </Box>
                                <TextField
                                   variant='outlined'
                                   name="room_code"
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
                                    <Button disabled={disable_join} fullwidth={"true"} variant="contained" color='secondary' aria-label='submit' type='submit'>Join Game</Button>
                                </Box>
                         </form>
                        </Box>
                    </Box>
                    </Grid>
                </Grid>
            </React.Fragment>
            </ThemeProvider>
        );
    }
}
export default Home;