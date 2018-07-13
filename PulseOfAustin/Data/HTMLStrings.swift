//
//  HTMLStrings.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 7/11/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import Foundation

enum HTMLStrings {
    static let htmlTemplate = """
        <!DOCTYPE html>
        <html>
        <head>
            <style>
                body {
                    font-size: 36pt;
                }
                .cardTitle {
                    font-size: 40pt;
                    font-family: Futura-Bold;
                    margin-top: 0;
                }
                .paragraphTitle {
                    font-family: Futura;
                }
                .row {

                }
                .column1 {
                    width: 21%;
                    display: inline-block;
                    font-family: Futura-Bold;
                    font-size: 40pt;
                    vertical-align: top;
                }
                .column2 {
                    width: 77%;
                    text-align: left;
                    display: inline-block;
                    font-size: 36pt;
                }
            </style>
        </head>
        <body>
            #HTML_CONTENT#
        </body>
        </html>
    """
    static let affordableHousingCardContent = [affordableHousingCard1, affordableHousingCard2, affordableHousingCard3, affordableHousingCard4]
    static let affordableHousingCard1 = """
        <div>
            <p class="cardTitle">OVERVIEW</p>
            <div>
                <p style="">The cost of closing Austin’s Affordable Housing Gap today is around $6.48 Billion (48,000 unit gap).</p>
                <p style="">The cost of closing Austin’s Affordable Housing Gap in 2025 is projected to be $11.18 Billion.</p>
                <div style="font-family: Futura-Medium; font-weight: 400">BOND IMPACT</div>
                <div style="">$161M: 1,900 affordable units <br>
                    $300M: 7,000+ affordable units</div>
            </div>
        </div>
    """
    static let affordableHousingCard2 = """
        <div>
            <p class="cardTitle">BOND BREAKDOWN</p>
            <div style="position: relative;">
                <div class="column1">47%</div>
                <div class="column2">Rental Housing Development Assistance Projects</div>
            </div>
            <div style="position: relative;">
                <div class="column1">31%</div>
                <div class="column2">Land Acquisition</div>
            </div>
            <div style="position: relative;">
                <div class="column1">11%</div>
                <div class="column2">Acquisition and Development Homeownership Program</div>
            </div>
            <div style="position: relative;">
                <div class="column1">11%</div>
                <div class="column2">Home Repair Program</div>
            </div>
        </div>
    """
    static let affordableHousingCard3 = """
        <div>
            <p class="cardTitle">ON THE BALLOT</p>
            <div style="position: relative;">
                <div class="column1" style="width: 27%">$112M</div>
                <div class="column2" style="width: 71%">Stormwater (drainage and dams)</div>
            </div>
            <div style="position: relative;">
                <div class="column1" style="width: 27%">$117M</div>
                <div class="column2" style="width: 71%">Parkland and Open Space (water quality protection + new parkland)</div>
            </div>
            <div style="position: relative;">
                <div class="column1" style="width: 27%">$179M</div>
                <div class="column2" style="width: 71%">Transportation Infrastructure (bridges + street reconstruction)</div>
            </div>
            <div style="position: relative;">
                <div class="column1" style="width: 27%">$281M</div>
                <div class="column2" style="width: 71%">Facilities & Assets (Fire Dept., EMS, arts & culture centers, parks & rec, libraries, public health)</div>
            </div>
        </div>
    """
    static let affordableHousingCard4 = """
        <div>
            <p class="cardTitle">CITY VIEWPOINTS</p>
            <div class="paragraphTitle">HOUSING COMMITTEE</div>
            <div>Fearing residents would reject a larger bond,
                they suggest a $161 million bond focusing on lack
                of affordability all over town, especially West of I-35.</div>
            <p>
                <div class="paragraphTitle">COUNCIL MEMBER CASAR</div>
                <div>“Austin needs to make a significant investment in building
                    new affordable housing, we should be bold but careful.
                    I support a $300 million bond.”</div>
            </p>
        </div>
    """
}
