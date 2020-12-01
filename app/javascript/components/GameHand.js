import React from "react"
import PropTypes from "prop-types";
import { Card, CardStyles } from 'react-casino';
import Container from '@material-ui/core/Container';
import '../../assets/stylesheets/application.css';

class GameHand extends React.Component {
    render () {
        console.log(this.props.cards)
        console.log(this.props.piles)
        return (
            <React.Fragment>
                {/*{this.props.cards[0][0]}*/}
                {/*<Card suit="S" face="A" />*/}
                <div id='player1Hand'>
                    <div id='card1' className='pile'>
                        <Card suit="D" face="9" style={{width: "75px", height: "108"}}/>
                    </div>
                    <div id='card2' className='pile'>
                        <Card suit="S" face="A" style={{width: "75px", height: "108"}}/>
                    </div>
                </div>
            </React.Fragment>
        );
    }
}



GameHand.propTypes = {
    cards: PropTypes.array,
    piles: PropTypes.array
};

export default GameHand