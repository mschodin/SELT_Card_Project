import PropTypes from "prop-types";
import {makeStyles, ThemeProvider} from "@material-ui/core";
import Alert from '@material-ui/lab/Alert';
import React from "react";
import Collapse from "@material-ui/core/Collapse";
import IconButton from "@material-ui/core/IconButton";
import CloseIcon from '@material-ui/icons/Close';

const useStyles = makeStyles((theme) => ({
    root: {
        width: '100%',
        '& > * + *': {
            marginTop: theme.spacing(2),
        },
    },
}));

export default function FlashMessage(props){
    const classes = useStyles();
    const [open, setOpen] = React.useState(true);
        return(
            <div className={classes.root}>
                <Collapse in={open}>
                    <Alert
                        action={
                            <IconButton
                                aria-label="close"
                                color="inherit"
                                size="small"
                                onClick={() => {
                                    setOpen(false);
                                }}
                            >
                                <CloseIcon fontSize="inherit" />
                            </IconButton>
                        }
                    >
                        {props.alert}
                    </Alert>
                </Collapse>
            </div>
        );
            // <Alert onClose={() => {}} severity="error"> this.props.alert </Alert>
}

FlashMessage.propTypes = {
    alert: PropTypes.string
};