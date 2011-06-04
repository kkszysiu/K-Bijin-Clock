        function getMinutes(time) {
            var currTime = time+""
            var minutes = currTime.slice(3, 5)
            return minutes
        } 

        function getHour(time) {
            var currTime = time+"" // TODO: find a better way to convert it to string!
            var hour = currTime.slice(0, 2)
            //console.log(time.substr(11,16))
            return hour
        } 

        function generateImageURLFromTime(patternUrl, time) {
            var hour = getHour(time)
            var minutes = getMinutes(time)
            var url = patternUrl.replace("%H", hour).replace("%M", minutes)
            console.log(url)
            return url
        }