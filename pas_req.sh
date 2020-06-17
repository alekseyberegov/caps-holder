#/bin/bash

url_encode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"
  REPLY="${encoded}"
}

function join_by { local d=$1; shift; echo -n "$1"; shift; printf "%s" "${@/#/$d}"; }

# ##############################################################################################################

user_id="1f01ea64-d298-45ab-ac6b-33ed7f41572d"

user_agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 Chrome/83.0.4103.97 Safari/537.36"

user_segments='{"typeOne":[],"typeTwo":[]}'

page_url="https://nypost.com/2020/06/02/warner-bros-makes-just-mercy-free-to-rent-for-systemic-racism-education/"

pas_url="https://www.clicktripz.com/x/pas"

# ##############################################################################################################

pas_serv="$(echo ${pas_url} | grep :// | sed -e's,^\(.*://\).*,\1,g')"
pas_path="$(echo ${pas_url/$pas_serv/})"
pas_host="$(echo ${pas_path} | cut -d/ -f1)"

pas_params=$(join_by "&"  \
   "ctzpid=$(uuidgen)" \
   "alias=nypost" \
   "placementId=2949-0" \
   "siteId=nypost" \
   "obj=exit_unit" \
   "ref=$(url_encode $page_url)" \
   "optMaxChecked=2" \
   "optMaxAdvertisers=7" \
   "optRotationStrategy=1" \
   "optPopUnder=1" \
   "optLocalization=en" \
   "audiences=$(url_encode $user_segments)" \
   "tabbedMode=1" \
   "userForcedTabbedMode=1" \
   "callback=jsonp_callback_1" \
   )

curl  "${pas_url}?${pas_params}" \
  -H "authority:${pas_host}" \
  -H "user-agent: ${user_agent}" \
  -H 'accept: */*' \
  -H 'sec-fetch-site: cross-site' \
  -H 'sec-fetch-mode: no-cors' \
  -H 'sec-fetch-dest: script' \
  -H "referer: ${page_url}" \
  -H 'accept-language: en-US,en;q=0.9,ru;q=0.8' \
  -H "cookie: _ctuid=${user_id};" \
  --compressed

