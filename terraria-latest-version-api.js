// Hosted on https://runkit.com/paul1365972/terraria-latest-version-api

const url = require('url')
const { send } = require('micro')
const axios = require('axios')
const xpath = require('xpath-html');

const terrariaUrl = 'https://terraria.org'
const selector = "//*[text() = 'PC Dedicated Server']"

exports.endpoint = async function (req, res) {
    try {
        const redirect = new URL(req.url, 'https://localhost/').searchParams.get('dl')

        const html = await axios(terrariaUrl).then(res => res.data)
        const node = xpath.fromPageSource(html).findElement(selector);
        const dlUrl = terrariaUrl + node.getAttribute('href')

        if (redirect == '1') {
            res.setHeader('Location', dlUrl)
            send(res, 307)
        } else {
            send(res, 200, dlUrl)
        }
    } catch (e) {
        console.log(e)
        send(res, 500, 'Internal Server Error')
    }
}
