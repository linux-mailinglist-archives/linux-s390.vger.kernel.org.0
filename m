Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E066F46CD7A
	for <lists+linux-s390@lfdr.de>; Wed,  8 Dec 2021 07:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbhLHGNp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Dec 2021 01:13:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44196 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhLHGNn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Dec 2021 01:13:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09D74B81FB9;
        Wed,  8 Dec 2021 06:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF046C341CA;
        Wed,  8 Dec 2021 06:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638943809;
        bh=NyTNAO9PvUgjX7VNgjVXGnfPJrD5Ozr/SBQ+0zQ+XRQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QwRoHzCWtDDnP5K7LgJP0J9ZqQuxsV8G5Fqtzj3l4wiyG5CjrH018frYajLzlExNG
         GLeQIQwPH5ReVUErktY+j5QfiVx7WY98XN/dGwKJeOz2+7uqTd6as2+jtSwCS2mPsE
         NNpdWzK85+N8BGR5aJ4n4NASBUXN6nVajVH6rSkhpy9I8btdfOQkLr6jtojtaVbtwg
         c6PxCvewcsQnQ5xIpwtCEHmdqVcYOYAzvdwzPHUhfV2S/VCT54E6iOzSnJF/u940mX
         T2s5OdFZ130RaRHP5GJBTnjQDuV5QnPqGv+rkG2fzehw0LNmlBGAEEPiXVpBwWDszk
         FCRhSj/fnH4qQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9ECC560A36;
        Wed,  8 Dec 2021 06:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] s390/net: updates 2021-12-06
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163894380964.19666.11567657838514887134.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Dec 2021 06:10:09 +0000
References: <20211207090452.1155688-1-wintera@linux.ibm.com>
In-Reply-To: <20211207090452.1155688-1-wintera@linux.ibm.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, jwi@linux.ibm.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Dec 2021 10:04:47 +0100 you wrote:
> Please apply the following patches to netdev's net-next tree.
> 
> This brings some maintenance improvements and removes some
> unnecessary code checks.
> 
> Julian Wiedmann (5):
>   s390/qeth: simplify qeth_receive_skb()
>   s390/qeth: split up L2 netdev_ops
>   s390/qeth: don't offer .ndo_bridge_* ops for OSA devices
>   s390/qeth: fine-tune .ndo_select_queue()
>   s390/qeth: remove check for packing mode in
>     qeth_check_outbound_queue()
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] s390/qeth: simplify qeth_receive_skb()
    https://git.kernel.org/netdev/net-next/c/5e9756a66fb5
  - [net-next,2/5] s390/qeth: split up L2 netdev_ops
    https://git.kernel.org/netdev/net-next/c/2dbc7a1dde9e
  - [net-next,3/5] s390/qeth: don't offer .ndo_bridge_* ops for OSA devices
    https://git.kernel.org/netdev/net-next/c/cdf8df5b42e7
  - [net-next,4/5] s390/qeth: fine-tune .ndo_select_queue()
    https://git.kernel.org/netdev/net-next/c/1b9e410f45bf
  - [net-next,5/5] s390/qeth: remove check for packing mode in qeth_check_outbound_queue()
    https://git.kernel.org/netdev/net-next/c/6dc490e80ca3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


