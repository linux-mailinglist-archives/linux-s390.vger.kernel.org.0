Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22EB2D1454
	for <lists+linux-s390@lfdr.de>; Mon,  7 Dec 2020 16:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLGPEw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 7 Dec 2020 10:04:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33966 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgLGPEw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 10:04:52 -0500
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2020 10:04:52 EST
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id A46E2436ABFEB;
        Mon,  7 Dec 2020 06:57:17 -0800 (PST)
Date:   Mon, 07 Dec 2020 06:57:13 -0800 (PST)
Message-Id: <20201207.065713.357907127824978080.davem@davemloft.net>
To:     jwi@linux.ibm.com
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, kgraul@linux.ibm.com
Subject: Re: [PATCH net-next 0/6] s390/qeth: updates 2020-12-07
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20201207131233.90383-1-jwi@linux.ibm.com>
References: <20201207131233.90383-1-jwi@linux.ibm.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Mon, 07 Dec 2020 06:57:17 -0800 (PST)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon,  7 Dec 2020 14:12:27 +0100

> Hi Jakub,
> 
> please apply the following patch series for qeth to netdev's net-next tree.
> 
> Some sysfs cleanups (with the prep work in ccwgroup acked by Heiko), and
> a few improvements to the code that deals with async TX completion
> notifications for IQD devices.
> 
> This also brings the missing patch from the previous net-next submission.

Series applied, thanks Julian!
