Psapi = require '../lib/psapi.coffee'

describe 'Psapi', ->

  describe '#listen', ->

    it 'listens on the specified port', ->
      express =
        listen: sinon.spy()
        use: sinon.spy()
      psapi = new Psapi routes: {}, express: -> express
      psapi.listen 5000
      expect(express.listen).to.have.been.calledWith 5000

  describe '#prepPayload', ->

    it 'returns a fuction producing an array of functions when given an array', ->
      psapi = new Psapi routes: {}
      input = ['a']
      output = psapi.prepPayload input
      expect(typeof output).to.eq 'function'
      expect(output()[0]()).to.eq 'a'

    it 'returns a fuction producing an object of functions when given an object', ->
      psapi = new Psapi routes: {}
      input = a: 1
      output = psapi.prepPayload input
      expect(typeof output).to.eq 'function'
      expect(output()['a']()).to.eq 1

    it 'uses handlebars to compile strings into functions', ->
      psapi = new Psapi routes: {}
      input = '{{a}}'
      output = psapi.prepPayload input
      expect(typeof output).to.eq 'function'
      expect(output(a: 1)).to.eq '1'

    it 'wraps everything else into a function', ->
      psapi = new Psapi routes: {}
      input = 1
      output = psapi.prepPayload input
      expect(typeof output).to.eq 'function'
      expect(output()).to.eq 1

  describe '#executePayload', ->

    it 'executes functions in an array-based payload', ->
      psapi = new Psapi routes: {}
      input = ['a']
      prepped = psapi.prepPayload input
      output = psapi.executePayload prepped, {}
      expect(output[0]).to.eq 'a'

    it 'executes functions in an object-based payload', ->
      psapi = new Psapi routes: {}
      input = a: 1
      prepped = psapi.prepPayload input
      output = psapi.executePayload prepped, {}
      expect(output['a']).to.eq 1

    it 'provides a context to handlebars functions', ->
      psapi = new Psapi routes: {}
      input = '{{a}}'
      prepped = psapi.prepPayload input
      output = psapi.executePayload prepped, a: 1
      expect(output).to.eq '1'

  describe '#routeHandler', ->

    it 'returns an express callback which returns the processed payload', ->
      psapi = new Psapi routes: {}
      payload = psapi.prepPayload a: '{{a}}'
      handler = psapi.routeHandler payload, 200
      expect(typeof handler).to.eq 'function'
      req =
        params:
          a: 1
        query: {}
        body: {}
      statusRes = json: sinon.spy()
      res = status: sinon.stub()
      res.status.withArgs(200).returns statusRes
      handler req, res
      expect(statusRes.json).to.have.been.calledWith a: '1'


