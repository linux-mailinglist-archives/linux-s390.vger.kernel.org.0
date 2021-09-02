Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032913FF3DF
	for <lists+linux-s390@lfdr.de>; Thu,  2 Sep 2021 21:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347245AbhIBTKY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-s390@lfdr.de>); Thu, 2 Sep 2021 15:10:24 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50395 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347140AbhIBTKY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Sep 2021 15:10:24 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B207D1BF206;
        Thu,  2 Sep 2021 19:09:18 +0000 (UTC)
Date:   Thu, 2 Sep 2021 21:09:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, gregkh@linuxfoundation.org,
        chaitanya.kulkarni@wdc.com, atulgopinathan@gmail.com, hare@suse.de,
        maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        colin.king@canonical.com, shubhankarvk@gmail.com,
        baijiaju1990@gmail.com, trix@redhat.com,
        dongsheng.yang@easystack.cn, ceph-devel@vger.kernel.org,
        richard@nod.at, vigneshr@ti.com, sth@linux.ibm.com,
        hoeppner@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, oberpar@linux.ibm.com, tj@kernel.org,
        linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] mtd: add add_disk() error handling
Message-ID: <20210902210917.54eb6e26@xps13>
In-Reply-To: <20210902174105.2418771-6-mcgrof@kernel.org>
References: <20210902174105.2418771-1-mcgrof@kernel.org>
        <20210902174105.2418771-6-mcgrof@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Luis,

Luis Chamberlain <mcgrof@kernel.org> wrote on Thu,  2 Sep 2021 10:41:01
-0700:

> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
