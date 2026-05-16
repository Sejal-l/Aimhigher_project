const mongoose = require('mongoose');

const resultSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  answers: [
    {
      questionId: String,
      answer: String
    }
  ],
  score: {
    type: Number,
    default: 0
  },
  careerSuggestion: {
    type: String,
    required: true
  },
  reasoning: {
    type: String // To store WHY this career was suggested (Rule-based AI logic)
  }
}, {
  timestamps: true // This covers the createdAt field automatically
});

module.exports = mongoose.model('Result', resultSchema);