Return-Path: <linux-s390+bounces-18632-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMVUIlyR1mmiGQgAu9opvQ
	(envelope-from <linux-s390+bounces-18632-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Apr 2026 19:33:16 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 274E03BF9E8
	for <lists+linux-s390@lfdr.de>; Wed, 08 Apr 2026 19:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03860305A274
	for <lists+linux-s390@lfdr.de>; Wed,  8 Apr 2026 17:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E8C3D8113;
	Wed,  8 Apr 2026 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5eiAIuU"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DFF26A1AF;
	Wed,  8 Apr 2026 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669386; cv=none; b=HyDL8OoZ5HrwLdFkiUn+CHZKLQiHEyQgGys+9pDIrV3v5cBSRigXsFQhiadvxb1YB8njOuhu3wNcHatyjkHbDTejueEIcMLQJOR34gmoSC6rrhUsdMlZIF4Iza2hSOV62ku5JCOmOTNWgo9BCR6kDCnAqpKCYn8VLzpxurCR8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669386; c=relaxed/simple;
	bh=ZOkmcxvnnfhXmDnQWSF3Id0JVhFdSBA+mcixESi7MAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aPtSLwN69ihOPttfIqdA+fJb1v0SC6nNeqraTbGL/zVUeTM0uhmx6+j4PQLEAGUKYIxVw6kHZkXKRRq9Xs0pvXGi+aCZA3guGfHNkMMMoWrOqZMf0wCv/kiDGef25uSviOwygs+94b//2k4EHUzPSJaO2etRfupucQicP7VkBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5eiAIuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B60C19421;
	Wed,  8 Apr 2026 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669386;
	bh=ZOkmcxvnnfhXmDnQWSF3Id0JVhFdSBA+mcixESi7MAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=T5eiAIuUBCEp0491o1pBKGsLdiuyS68HpeHyPy1vXIq3LMDqsQ7UVTJYpmmtMkQSQ
	 ILt3Av7TezdIMqp08R6vC+gefprV0yY3x/sYtv52JYfWuP4iKBBkzTkrs8It5uXH7X
	 F1CLpzvAaLUZoMDT/vMSTxBlMp2kXYaH9/3bYee1m/5W8YtDbPTfLdwB0wyGEeMLEN
	 j0N+YO2Q4aK0pl5LNAqrNwvcQhQD4G0B0UKZ+e7gyLfTlttb6Rh60BQpOjPRZQOwiK
	 BzQyVuOXoy2ee0s/HTtN5wE6y1ZhXxcnL8lxKbclmEgKt+841Fk92IFDi79RTCpA+G
	 IT3HU3PTlVE9A==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, 
 Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com, japo@linux.ibm.com
In-Reply-To: <20260407100835.3488645-1-tmricht@linux.ibm.com>
References: <20260407100835.3488645-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] perf addr2line: Rework disable_add2line_warn
Message-Id: <177566938575.2704582.17568865541232169508.b4-ty@kernel.org>
Date: Wed, 08 Apr 2026 10:29:45 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18632-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namhyung@kernel.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 274E03BF9E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 07 Apr 2026 12:08:32 +0200, Thomas Richter wrote:
> Introduce configurable addr2line_disable_warn entry in the .perfconfig
> file. Clean up addr2line configuration.
> 
> V2 --> V3: Added comments from Kim Namhyung
>            - Use perf_config_bool() to read addr2line-disable-warn
> 	     value
> 	   - Move perfconfig.txt update to proper patch file.
> 	   - Fix invalid default value in documentation.
> V1 --> V2: Update perf-config documentation.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



