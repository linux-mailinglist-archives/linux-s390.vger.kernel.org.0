Return-Path: <linux-s390+bounces-7427-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA429E4C5A
	for <lists+linux-s390@lfdr.de>; Thu,  5 Dec 2024 03:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24FA281F29
	for <lists+linux-s390@lfdr.de>; Thu,  5 Dec 2024 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD5012C530;
	Thu,  5 Dec 2024 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRSCqx5h"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19479DC;
	Thu,  5 Dec 2024 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366387; cv=none; b=J814cskCJ+W7BHN2ayIdHGdR7YWF72uKRSgNOVUnP9KQnMQnHs8b24OL3/WL1ntBEvomaofi3YSfsVH38WN+NSW27IAmaX0ieYl/es6vYZtthnrOtA6ozHHTG/UcYoZsdyTNGXAi1UGPNapfUhw/mJFVwB+C0Jp/rbS3/escINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366387; c=relaxed/simple;
	bh=wCifLBtiH7uvFAQWr12TxflDBT7QOSS+B+BSxKTDQL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xg7SzWCNC0ZjmRFj3Wzu8aUu3/IQDS3xsj0BZp+yNWAOFHcbNRRB3upmPLO4jc+CsVzOBvQdCMoAZzBpOsXy5ei0DWFyoPHCefbM12qdzV48RbQcz2tw1AmnXQx4PRne9/5YbjYnzBHvRTMkmNw/LDqN48z4Vu2DcC3ZniVwY0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRSCqx5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B602FC4CECD;
	Thu,  5 Dec 2024 02:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733366387;
	bh=wCifLBtiH7uvFAQWr12TxflDBT7QOSS+B+BSxKTDQL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FRSCqx5hYhpH0pq/x+TwSCFqfC35fzNpfOEVfSNPIZHsGUfLg8wjR8InKYQivg4GJ
	 LZ2vrU2Vj85RczH96Z+5mphyawpcichvMb8iuecSr0b6zbxjzHm9EwZ7S16I6aR5qO
	 W/qx+/w0ibBL6kD1fJ9i6bSLe60OQ4xlD3jz3BPLTyqyEhcyjoGePKNfkXrGvyf1oB
	 LcjvG7MEdxuhBfmIkRfjpMTB0RlijFZqwr2PE4fjCm+wVV+pDsZCTZDJmQ+v/gzRy6
	 0uVFTeRKEron3C9qvtQUyJT/EvRL1eP68AYP9VTNrHQbgWGMU2wLRxF0Na0BrdQCnP
	 M1skWTIQ+apBA==
Date: Wed, 4 Dec 2024 18:39:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net/smc: Two features for smc-r
Message-ID: <20241204183945.47759ac5@kernel.org>
In-Reply-To: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
References: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Dec 2024 20:52:01 +0800 Guangguan Wang wrote:
> net/smc: Two features for smc-r

changes look relatively straightforward, IBM folks do you need more
time to review?

