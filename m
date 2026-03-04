Return-Path: <linux-s390+bounces-16834-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKYWNmVFqGlOrwAAu9opvQ
	(envelope-from <linux-s390+bounces-16834-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 04 Mar 2026 15:44:53 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DA3201D8A
	for <lists+linux-s390@lfdr.de>; Wed, 04 Mar 2026 15:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7D423004D0D
	for <lists+linux-s390@lfdr.de>; Wed,  4 Mar 2026 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6563C3ACF07;
	Wed,  4 Mar 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvojiLcr"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225F3A6EFB;
	Wed,  4 Mar 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635105; cv=none; b=fIM5v+2Ft7N7ep8kC3wRIJUofPajFPqNwfeQqAygsfyojvg9nuPqf8glJ7qK9ZhcV/3jiuwa9ZuJ8FMZIzL1AIrgM0XY/IZ6imThAgk13JINYCcbpUuc/dKbJ3cpzONbAZ5Djuk4tVe8BX6aIUGzYBWEcWwuu2VhiygATukr7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635105; c=relaxed/simple;
	bh=04tgK67VQfSCDdfIg+sxFG4n0hzJTQoX9bRddb/f0z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guLW8eRdtbPGysZOIRJcw6SVphwq0dhxo/EF7o/A8+Kk43Uvek44085DLMDGsJvzs3u9MmCKfjbWCHLZYJ79J83gdrNQ4fQvWICdANtIdzSEPbxJhurR3qujigSP0q1DT/eOzH/ybOHhFU9DJHCOptea+dOoV6PYa41zoIzPjIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvojiLcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89212C2BC9E;
	Wed,  4 Mar 2026 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772635104;
	bh=04tgK67VQfSCDdfIg+sxFG4n0hzJTQoX9bRddb/f0z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvojiLcrJAirG2FA6Fk322XxFyqmIsJsJ8vmwI8DeNAkCplNHkAyWRRcjGqspW1j4
	 XZ90BYGRVobTNjsc/CnpSEiqV5PK0gzCCjST583Yo2iSEC0rijLVnpMP/KMsAyJ+s9
	 PO4qDPjVB7bBSdsBQCcWDDF3nhJeyPcUPjREwugXjIml5wJmkePnbIE+Dmia0pKt9g
	 Gy21TjXULenzNfCgQH0rho67Ub4yLf+3icNncOI6dBenKeZ+OwUxInp00fjBSBI9s2
	 tLLnjbXKcp8bNwc01JPsikwnW1IyZJjoOEJmbaIgxwVCxCS1t07Q8Pc61Q/+rfyycR
	 Ttxu7WRwq5NcQ==
Date: Wed, 4 Mar 2026 15:38:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/9] s390/idle: Add comment for non obvious code
Message-ID: <aahD3rvBCSl6xjbx@localhost.localdomain>
References: <20260218142012.863464-1-hca@linux.ibm.com>
 <20260218142012.863464-4-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218142012.863464-4-hca@linux.ibm.com>
X-Rspamd-Queue-Id: 82DA3201D8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16834-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,localhost.localdomain:mid]
X-Rspamd-Action: no action

Le Wed, Feb 18, 2026 at 03:20:06PM +0100, Heiko Carstens a écrit :
> Add a comment to update_timer_idle() which describes why wall time (not
> steal time) is added to steal_timer. This is not obvious and was reported
> by Frederic Weisbecker.
> 
> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Closes: https://lore.kernel.org/all/aXEVM-04lj0lntMr@localhost.localdomain/
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

