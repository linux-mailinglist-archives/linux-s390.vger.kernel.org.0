Return-Path: <linux-s390+bounces-16839-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MlRIBZNqGnUswAAu9opvQ
	(envelope-from <linux-s390+bounces-16839-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 04 Mar 2026 16:17:42 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38051202713
	for <lists+linux-s390@lfdr.de>; Wed, 04 Mar 2026 16:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34014307DC96
	for <lists+linux-s390@lfdr.de>; Wed,  4 Mar 2026 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09013451B2;
	Wed,  4 Mar 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aACN1Gak"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C3344DB0;
	Wed,  4 Mar 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636861; cv=none; b=g85UAmnEn5WLu+Rtyv+wHHVJeHHug1fcS6Kd8urpH4MBN3IxbQCnoR79gR6uja0cWrfbWYeOprsLph1NyfMrpON5XSLQ2T2DoZMhnQiN8RwKHyXd1AWNonyYhydrQApDNOVkGvfjUOiAvOsVujGdsA23ZXSyN/8o0bT0ZzNuwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636861; c=relaxed/simple;
	bh=ztKTt2d8oyhp7VXVhzxskCg4q6wLBMD7QwJKGcJW+3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYdmbgfSjCPzwCRgC0nFmnbxUganes1/eeWhO+FSGb/ASMs6Hg7ho+RgYC6tJxjEmZnQS+LVT6W5n9Bz0wu62wo6E9vu8seQCDn0FjUtW71WbLfB+Lm0+stpDY0Ic//+iGjXQUyC0xEBmshMTgM81Q3rr7uDvgjkOzawfE8oMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aACN1Gak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC0CC4CEF7;
	Wed,  4 Mar 2026 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772636861;
	bh=ztKTt2d8oyhp7VXVhzxskCg4q6wLBMD7QwJKGcJW+3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aACN1GakVchRRFJA5sTAs6ySfgdS3D8h+s9LcV48OmIf302pml/+2gppp2chiAqwn
	 Xh4GqByVVfN22Lrg+KWtimQ63DHPtEVgq9L9EveStdftwsvZqDkseGQ5sSqUX/vYN0
	 MluMCB/k6C7W4WYlgOHoHgPKfK+MbQIbdQevP5YPiEF9xUzdNwOOXDej8X3zAwpQNM
	 wb8n3SWnBQgvPc2AlBGg8/31dZLHhAdsQvDJwhiFNPoe4NIXpgMz9Myree7jwPBZry
	 UeL7LvYlQ2iLlkv2Wjs+wbZLj8rlxVhUgpX+sF7t0N03b9yVzASmi1evxWbqJOneaB
	 JcpvONyyoP6Dw==
Date: Wed, 4 Mar 2026 16:07:38 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 5/9] s390/idle: Inline update_timer_idle()
Message-ID: <aahKuhrNX4gQRNFC@localhost.localdomain>
References: <20260218142012.863464-1-hca@linux.ibm.com>
 <20260218142012.863464-6-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218142012.863464-6-hca@linux.ibm.com>
X-Rspamd-Queue-Id: 38051202713
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16839-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Le Wed, Feb 18, 2026 at 03:20:08PM +0100, Heiko Carstens a écrit :
> Inline update_timer_idle() again to avoid an extra function call. This
> way the generated code is close to old assembler version again.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

