tetris = {
	children : [
		                /*for, while*/ "init", "test", "update", 
		                /*block,program, while*/ "body", 
		                /*expression*/ "expression",
		                /*assignment*/ "operator", "left", "right", "prefix",
		                /*call*/ "callee", "arguments",
		                /*identifier*/ "name",
		                /*literal*/ "value",
		                /*object*/ "properties",
		                /*if*/ "consequent", "alternate", 
		                /*switch*/ "lexical", "cases", "discriminant", 
		                /*return*/ "argument"],
		
	/**
	 * traverses ReflectJS AST, calling visitor for each visited node. Visitor structure:
	 * 
	 * pre visit callbacks:
	 * visitor.pre<NodeType> - called before entering node of given type
	 *   example: visitor.preExpressionStatement - called before entering ExpressionStatement
	 * visitor.preVisit - called before entering node, if specific pre<NodeType> is not defined
	 * 
	 * Returning false in pre-visitor prevents traversing current node. 
	 * 
	 * post visit callbacks:
	 * visitor.<NodeType> - called after visiting node of given type
	 *   example: visitor.ExpressionStatement - called after visiting ExpressionStatement node
	 * visitor.visit - called after visiting node, if specific <NodeType> is not defined
	 * 
	 * all callbacks get current node passed as first argument
	 * 
	 * @param ast
	 * @param visitor
	 */
	traverse : function(ast, visitor) {
		if (ast) {
			var enter = undefined;
			if (visitor["pre"+ast.type]) {
				enter = visitor["pre"+ast.type](ast);
			} else if (visitor.preVisit) {
				enter = visitor.preVisit(ast);
			}

			if (enter !== false) {
				
				for (var i in tetris.children) {
					var child = tetris.children[i];
					if (ast[child]) {
						if (ast[child].length) {
							for ( var i = 0; i < ast[child].length; i++) {
								tetris.traverse(ast[child][i], visitor);
							}
						} else {
							tetris.traverse(ast[child], visitor);
						}
					}
				}
			}
			
			if (visitor[ast.type]) {
				visitor[ast.type](ast);
			} else if (visitor.visit) {
				enter = visitor.visit(ast);
			}
		}

	},
	
	process : function(ast) {
		console.log(ast);

		visitor = {
				/*preProgram : function(node) {
					// empty
				},
				
				preExpressionStatement : function(node) {
					// empty
				},
				
				preForStatement : function(node) {
					// empty
				},
				
				preBlockStatement : function(node) {
					// empty
				},
				
				preWhileStatement : function(node) {
					// empty
				},
				
				preSwitchStatement : function(node) {
					// empty
				},
				
				preReturnStatement : function(node) {
					// empty
				},
				
				preIfStatement : function(ifNode) {
					$("#dest").append("if? ");
				},*/
				
				str : "",
				
				preVisit : function(node) {
					this.str += "<div class='node'>"+node.type;
					for (i in node) {
						if ((jQuery.inArray(i, ["loc", "type"]) === -1) && 
							(jQuery.inArray(i, tetris.children) === -1)) {
							this.str += "<div class='member'>+"+node.type+"."+i+"</div>";
						}
					}
				},
				
				visit : function(node) {
					this.str += "</div>";
				}
				
		};
		tetris.traverse(ast, visitor);

		$("#dest").empty();
		$("#dest").append(visitor.str);

	}
};
