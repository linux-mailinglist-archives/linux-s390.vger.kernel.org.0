Return-Path: <linux-s390+bounces-16780-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJVMF3QQp2nFdAAAu9opvQ
	(envelope-from <linux-s390+bounces-16780-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 03 Mar 2026 17:46:44 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D7E1F4103
	for <lists+linux-s390@lfdr.de>; Tue, 03 Mar 2026 17:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE78631055A6
	for <lists+linux-s390@lfdr.de>; Tue,  3 Mar 2026 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE521364E95;
	Tue,  3 Mar 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkhP8vPY"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B13264FF;
	Tue,  3 Mar 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556026; cv=none; b=GA+hMMgNHB9ipZANB4xLMMQC+6epyI509dmB3t6o0+XfjkJG/qRoRMHse+jMpLMeLhARWQF+jWv+lSyZ5blQQQ822bxbNCcZ0DxZtcaF3McujK5CoVjn/4CueRdiEWXMXmkhr7z/bytm2vEf51QLtBq/GKdG/aljRCBJaAh/UHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556026; c=relaxed/simple;
	bh=pv4uHMhlbgypAbm5pDZYwMJLiSHn7pMqXbknA5eTnaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fo+0v8H1H/PTrV87lUdZU78Kjnb/9CDVwoeMkiwYQYJyCjItyEcXfkvF2i4EbG1g0dQGaMG3+fk7UIqUziBFgXZup3OG5WWQ07sLAnEC8YRSnQSF2fJdkzCl4upBohNYupsCQUYcHp9ixV+EvICr3ScgkdF+fmBiJWZmiIRPW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkhP8vPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747D1C116C6;
	Tue,  3 Mar 2026 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556026;
	bh=pv4uHMhlbgypAbm5pDZYwMJLiSHn7pMqXbknA5eTnaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AkhP8vPYkWkXBfjxEspOeh22doJ02kIUs/AG8wjxTngzeFU/Dd8BExyZ3I4BH9YzO
	 TEiPNRBZVgthxn0s4LOyYjAn1C0TAt5P5UDpV13T4PyhAeFBGMW863IKsWEz8Bem8d
	 V/INAsK1I3LdSil9muK+RA4w758SEl8TQAle8FNuyGuR8BX73aLjqAAv6h4uyUqGj7
	 cvrZjH6nbWulfzlg9tdT2ZSAHxF+A6oB6g7UFQAMoDoydhBAeFIv/Mq6qreIXp0yBI
	 ak/oK/ZtdZw+9eJoRAxwBb5VuZROXBqufH4rlQQwyM8jlWHHRp/FgJIEsR31unEhti
	 ULPIsRR2LwJMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DE63808200;
	Tue,  3 Mar 2026 16:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] bpf: fsession support for s390
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177255602754.1378092.5707758815571670243.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 16:40:27 +0000
References: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, iii@linux.ibm.com, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, bpf@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 00D7E1F4103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16780-lists,linux-s390=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Feb 2026 17:22:05 +0800 you wrote:
> Implement bpf fsession for the s390 architecture.
> 
> Changes v2 -> v1:
> * keep LGHI as it was in the 1st patch
> * fix up the comment style
> * remove the unnecessary checking of fentry->nr_links and fexit->nr_links
>   in the 2nd patch
> * v1: https://lore.kernel.org/bpf/20260223084022.653186-1-dongml2@chinatelecom.cn/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf,s390: introduce emit_store_stack_imm64() for trampoline
    https://git.kernel.org/bpf/bpf-next/c/339193c44e75
  - [bpf-next,v2,2/3] bpf,s390: add fsession support for trampolines
    https://git.kernel.org/bpf/bpf-next/c/63d2b7d10126
  - [bpf-next,v2,3/3] selftests/bpf: factor out get_func_* tests for fsession
    https://git.kernel.org/bpf/bpf-next/c/c1eee8d1e84f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



