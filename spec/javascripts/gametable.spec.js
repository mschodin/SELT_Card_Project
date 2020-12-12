import * as React from "react";
import {render} from "@testing-library/react";
import GameRoom from "../../app/javascript/components/GameRoom";
import GameTable from "../../app/javascript/components/GameTable";
import PropTypes from "prop-types";

test('Check that GameTable with correct number of piles', () => {
    const test_piles =  [[0,[["A", "S", 0],["A", "C", 1],["A", "H", 2]]],[ 1, [["A", "S", 0],["A", "C", 1],["A", "H", 2]]]]
    const test_hand =  [["A", "S", 0],["A", "C", 1],["A", "H", 2]]
    const test_ptd = {0:[], 1:[]}
    const test_players = {"Juan":0 }
    const test_player = {"name": "Juan" }
    const { getAllByRole } = render(
        <GameRoom
            handId={0}
            playerHand={test_hand}
            piles={test_piles}
            piles_to_deck={ test_ptd }
            create_deck_urls={"example_url/create_deck/__pile_id__"}
            roomId={0}
            players={test_players}
            draw_multiple={"example_url/draw_multiple"}
            room_passcode={"CODE"}
            player={test_player}
        />);
    expect(getAllByRole('pile').length).toBe(test_piles.length)
});

