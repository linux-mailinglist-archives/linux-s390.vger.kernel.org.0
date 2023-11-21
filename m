Return-Path: <linux-s390+bounces-1-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7547F22C3
	for <lists+linux-s390@lfdr.de>; Tue, 21 Nov 2023 02:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0ECB20CC5
	for <lists+linux-s390@lfdr.de>; Tue, 21 Nov 2023 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171617FC;
	Tue, 21 Nov 2023 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tGoFB+5w"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B2A17F2
	for <linux-s390@vger.kernel.org>; Tue, 21 Nov 2023 01:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D53C433C9;
	Tue, 21 Nov 2023 01:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700528556;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=tGoFB+5wsR/3vXAZRbehfQY+DSi0gHmJGDn08dy/8dMyJCCunLgiVT7ZJ/oDZ4GHh
	 pvbI5lCThmmFBQEJhTn7/DoEC7H+oYgMuyuPIe61psAH76xGOpOEWbP+v2rZSjgCpZ
	 NmgOPrQX0igFglNru9HhYKMtmzg92WRep9nb8aCo=
Date: Mon, 20 Nov 2023 20:02:35 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-s390@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-majestic-brown-quoll-a9f6ba@nitro>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K

