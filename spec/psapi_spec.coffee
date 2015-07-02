Psapi = require '../src/psapi.coffee'

describe 'Psapi', ->

  describe '#listen', ->

    it 'listens on the specified port', ->
      express =
        listen: sinon.spy()
        use: sinon.spy()
      psapi = new Psapi routes: {}, express: -> express
      psapi.listen 5000
      expect(express.listen).to.have.been.calledWith 5000


  describe '#_prepPayload', ->

    beforeEach ->
      @psapi = new Psapi routes: {}

    afterEach ->
      expect(typeof @output).to.be.a.function

    it 'returns a function producing an array of functions when given an array', ->
      @output = @psapi._prepPayload ['a']
      expect(@output()[0]()).to.eq 'a'

    it 'returns a fuction producing an object of functions when given an object', ->
      @output = @psapi._prepPayload a: 1
      expect(@output()['a']()).to.eq 1

    it 'uses handlebars to compile strings into functions', ->
      @output = @psapi._prepPayload '{{a}}'
      expect(@output(a: 1)).to.eq '1'

    it 'wraps everything else into a function', ->
      @output = @psapi._prepPayload 1
      expect(@output()).to.eq 1


  describe '#_executePayload', ->

    beforeEach ->
      @psapi = new Psapi routes: {}

    it 'executes functions in an array-based payload', ->
      prepped = @psapi._prepPayload ['a']
      output = @psapi._executePayload prepped, {}
      expect(output).to.eql ['a']

    it 'executes functions in an object-based payload', ->
      prepped = @psapi._prepPayload a: 1
      output = @psapi._executePayload prepped, {}
      expect(output).to.eql a: 1

    it 'provides a context to handlebars functions', ->
      prepped = @psapi._prepPayload '{{a}}'
      output = @psapi._executePayload prepped, a: 1
      expect(output).to.eq '1'


  describe '#_createRequestHandler', ->

    it 'returns an express callback which returns the processed payload', ->
      psapi = new Psapi routes: {}
      handler = psapi._createRequestHandler a: '{{a}}', 200
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


