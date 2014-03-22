$ ->

    $('#sidesOfDice').on 'change', (e) ->
        successThreshold = $('#successThreshold')
        sides = $(@)

        if parseInt(sides.val(), 10) < parseInt(successThreshold.val(), 10)
            successThreshold.val sides.val()

        successThreshold.attr 'max', sides.val()

    $('#diceRoller').on 'submit', (e) ->
        e.preventDefault()

        numberD = $('#numberOfDice').val()
        sidesD = $('#sidesOfDice').val()
        reverse = $('#successReversed:checked').val()
        successThreshold = $('#successThreshold').val()

        results = []

        for i in [1..numberD]
            results.push Math.ceil sidesD * Math.random()

        $('#resultSuccesses').val ->
            successes = []
            for i in results
                if (reverse? and i <= successThreshold) or (!reverse? and i >= successThreshold)
                    successes.push i
            successes.length

        $('#resultHighest').val _.max results
        $('#resultLowest').val _.min results

        $('#resultBreakdown').html ->
            breakdown = []
            if reverse?
                results.sort (a,b) -> a - b
            else
                results.sort (a,b) -> b - a
            for i in results
                if (reverse? and i <= successThreshold) or (!reverse? and i >= successThreshold)
                    i = "<strong>#{i}</strong>"
                breakdown.push i
            breakdown.join '<br>\n'
