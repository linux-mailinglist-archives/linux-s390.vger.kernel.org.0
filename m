Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90B31A6744
	for <lists+linux-s390@lfdr.de>; Mon, 13 Apr 2020 15:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgDMNlv (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 13 Apr 2020 09:41:51 -0400
Received: from verein.lst.de ([213.95.11.211]:34828 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbgDMNlu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Apr 2020 09:41:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9C1ED68BEB; Mon, 13 Apr 2020 15:41:47 +0200 (CEST)
Date:   Mon, 13 Apr 2020 15:41:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 03/10] block: cleanup hd_struct freeing
Message-ID: <20200413134147.GA16386@lst.de>
References: <20200408194439.1580699-1-hch@lst.de> <20200408194439.1580699-4-hch@lst.de> <SN4PR0401MB3598FDA8DB67BE8337A4C16B9BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598FDA8DB67BE8337A4C16B9BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Apr 09, 2020 at 11:30:19AM +0000, Johannes Thumshirn wrote:
> On 08/04/2020 21:45, Christoph Hellwig wrote:
> > -	struct hd_struct *part = container_of(to_rcu_work(work), struct hd_struct,
> > -					rcu_work);
> > +	struct hd_struct *part =
> > +		container_of(to_rcu_work(work), struct hd_struct, rcu_work);
> 
> That looks like an unneeded white space only change

It was intentional as I was touching the code right next to it anyway..
