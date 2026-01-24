# Development Rules & Principles
*Inspired by SuperClaude Framework - Enhanced for OpenCode local development*

## 🎯 Core Operating Principles

### **Read → Think → Validate → Execute → Verify**
- **Always read before writing** - Understand existing code structure and patterns
- **Think systematically** - Analyze requirements and plan approach before implementation  
- **Validate assumptions** - Check compatibility and dependencies before changes
- **Execute safely** - Use incremental changes with rollback capability
- **Verify results** - Test and confirm functionality after implementation

### **Quality Gates & Safety First**
- ✅ **Preview changes** before applying destructive operations
- ✅ **Use absolute paths** to avoid file operation confusion
- ✅ **Batch tool calls** when possible for efficiency
- ✅ **Validate before execution** - Check syntax, dependencies, compatibility
- ✅ **Complete discovery** before making codebase changes
- ✅ **Verify completion** with concrete evidence and testing

---

## 🏗️ Architecture & Design Principles

### **Systems Thinking**
- Design for **scalability** and **maintainability** from the start
- Consider **performance implications** of architectural decisions
- Plan for **security** at the system level, not as an afterthought
- Design **APIs first** - define interfaces before implementation
- Use **composition over inheritance** where possible

### **Code Organization**
- Follow **single responsibility principle** - one concern per module/function
- Maintain **clear separation of concerns** - UI, business logic, data layers
- Use **consistent naming conventions** throughout the project
- Keep **configuration separate** from logic
- Document **architectural decisions** and trade-offs

---

## 🎨 Frontend Development Standards

### **User Experience First**
- **Accessibility** is non-negotiable - follow WCAG guidelines
- **Performance budget** - measure and optimize Core Web Vitals
- **Mobile-first** responsive design approach
- **Progressive enhancement** - ensure graceful degradation
- **Error boundaries** and graceful error handling

### **Modern Frontend Practices**
- Use **semantic HTML** as the foundation
- **Component-driven development** with reusable patterns
- **State management** - choose appropriate patterns (local → context → global)
- **Type safety** - leverage TypeScript for better DX
- **Testing strategy** - unit, integration, and e2e coverage

---

## ⚙️ Backend Development Standards

### **API Design Excellence**
- **RESTful principles** or **GraphQL best practices**
- **Consistent error handling** with meaningful HTTP status codes
- **Request validation** and sanitization at entry points
- **Rate limiting** and **throttling** for API protection
- **Comprehensive logging** for debugging and monitoring

### **Data & Security**
- **Input validation** - never trust client data
- **SQL injection prevention** - use parameterized queries
- **Authentication & authorization** - implement proper session management
- **Data encryption** - at rest and in transit
- **Environment-specific configurations** - keep secrets secure

---

## 🛡️ Security-First Development

### **Threat Modeling Approach**
- **OWASP Top 10** compliance as baseline security
- **Principle of least privilege** - minimal necessary permissions
- **Defense in depth** - multiple security layers
- **Regular security audits** of dependencies and code
- **Incident response planning** - prepare for security events

### **Implementation Security**
- **Secure by default** configurations
- **Input sanitization** at all entry points
- **Output encoding** to prevent XSS
- **CSRF protection** for state-changing operations
- **Security headers** - CSP, HSTS, etc.

---

## ⚡ Performance & Optimization

### **Performance Budget Approach**
- **Measure first** - establish baseline metrics
- **Optimize critical path** - focus on user-perceived performance
- **Bundle optimization** - code splitting and lazy loading
- **Caching strategies** - appropriate at each layer
- **Database optimization** - query efficiency and indexing

### **Monitoring & Observability**
- **Real user monitoring** (RUM) for actual performance data
- **Synthetic monitoring** for proactive issue detection
- **Error tracking** with contextual information
- **Performance metrics** - track trends over time
- **Alerting thresholds** - notify before users are impacted

---

## 🧪 Testing & Quality Assurance

### **Comprehensive Testing Strategy**
- **Test pyramid** - unit (70%), integration (20%), e2e (10%)
- **Test-driven development** for critical business logic
- **Behavior-driven development** for user-facing features
- **Property-based testing** for complex algorithms
- **Visual regression testing** for UI consistency

### **Quality Metrics**
- **Code coverage** minimum thresholds (80%+ for critical paths)
- **Performance testing** - load and stress testing
- **Accessibility testing** - automated and manual validation
- **Security testing** - SAST and DAST integration
- **Usability testing** - real user feedback loops

---

## 🔄 Development Workflow

### **Version Control Best Practices**
- **Atomic commits** - one logical change per commit
- **Conventional commits** - standardized commit messages
- **Feature branching** - isolated development workflow
- **Code review** - mandatory for all changes
- **CI/CD pipeline** - automated testing and deployment

### **Collaboration Patterns**
- **Pair programming** for complex features and knowledge sharing
- **Documentation as code** - keep docs close to implementation
- **Regular refactoring** - address technical debt proactively
- **Post-mortem culture** - learn from incidents without blame
- **Knowledge sharing** - brown bags, demos, code walkthroughs

---

## 🚀 Local Development Environment

### **Development Setup Standards**
- **Consistent environments** - use Docker/containers when possible
- **Local testing** - full test suite should run locally
- **Hot reloading** - fast feedback loops during development
- **Development tools** - linting, formatting, type checking
- **Local SSL** - match production HTTPS behavior

### **Debugging & Troubleshooting**
- **Structured logging** - consistent format and levels
- **Debug configurations** - IDE and tool setup
- **Local monitoring** - track performance during development
- **Error reproduction** - create minimal failing examples
- **Documentation updates** - capture debugging insights

---

## 📋 Agent Collaboration Rules

### **Multi-Agent Workflows**
- **Architect** leads system design decisions
- **Security** reviews all authentication/authorization changes
- **Performance** evaluates optimization opportunities
- **Frontend/Backend** specialists lead their domain implementations
- **QA** validates all changes meet quality standards

### **Context Preservation**
- **Maintain decision history** across agent handoffs
- **Document architectural trade-offs** and reasoning
- **Share context** between related agents (frontend ↔ backend)
- **Validate consistency** when multiple agents collaborate
- **Escalate conflicts** to architect for resolution

---

## 💡 Continuous Improvement

### **Learning & Adaptation**
- **Regular retrospectives** - what's working, what isn't
- **Technology evaluation** - assess new tools and frameworks
- **Performance monitoring** - identify optimization opportunities
- **User feedback integration** - prioritize based on real usage
- **Best practice updates** - evolve rules based on experience

### **Innovation Balance**
- **Stability vs. innovation** - careful adoption of new technologies
- **Technical debt management** - balance new features with maintenance
- **Risk assessment** - evaluate impact of changes
- **Rollback planning** - prepare for quick recovery
- **Gradual migration** - avoid big-bang rewrites

---

*Remember: These rules should guide decisions, not constrain creativity. Use judgment and adapt based on project context and constraints.*